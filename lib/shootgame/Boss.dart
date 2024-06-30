import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'Bullet.dart';
import 'Explosion.dart';
import 'SpaceShooterGame.dart';

class Boss extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame>, CollisionCallbacks {
  Boss({
    super.position,
  }) : super(
    size: Vector2.all(enemySize),
    anchor: Anchor.center,
  );

  static const enemySize = 150.0;

  int HP = 15;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'boss.png',
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: .25,
        textureSize: Vector2(184,162),
      ),
    );

    // Constrain the position within screen bounds
    position.x = position.x.clamp(size.x/2, game.size.x - size.x/2);
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += dt * 75;
    if (position.y > game.size.y) {
      removeFromParent();
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
      } else {
        HP = HP -1;
        other.removeFromParent();
      }
    }
  }
}
