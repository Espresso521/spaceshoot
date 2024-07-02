import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'Bullet.dart';
import 'Explosion.dart';
import 'SpaceShooterGame.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  Enemy({
    super.position,
  }) : super(
    size: Vector2.all(enemySize),
    anchor: Anchor.center,
  );

  static const enemySize = 50.0;

  int HP = 2;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2.all(16),
      ),
    );

    // Constrain the position within screen bounds
    position.x = position.x.clamp(size.x/2, game.size.x - size.x/2);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += dt * 250;
    if (position.y > game.size.y) {
      removeFromParent();
      game.enemies.remove(this);
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      if(HP <=0) {
        removeFromParent();
        game.add(Explosion(position: position, onComplete: (){}));
        game.enemies.remove(this);
      } else {
        HP = HP -1;
        other.removeFromParent();
      }
    }
  }
}
