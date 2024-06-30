import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'SpaceShooterGame.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  Bullet({
    super.position,
  }) : super(
    size: Vector2(40, 50),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'bullets.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(16, 16),
      ),
    );

    add(
      RectangleHitbox(
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.y += dt * -500;

    if (position.y < -height) {
      removeFromParent();
    }
  }
}

