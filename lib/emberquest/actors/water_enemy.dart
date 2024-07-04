import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../animate/WaterExplosion.dart';
import '../ember_quest.dart';
import '../managers/segment_manager.dart';
import '../objects/fireball.dart';

class WaterEnemy extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame>, CollisionCallbacks {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  WaterEnemy({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(actorsSize), anchor: Anchor.bottomLeft);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      // game.images.fromCache('layers/enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        textureSize: Vector2.all(16),
        stepTime: 0.70,
      ),
    );
    position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
    );
    add(RectangleHitbox());
    add(
      MoveEffect.by(
        Vector2(-2 * size.x, 0),
        EffectController(
          duration: 3,
          alternate: true,
          infinite: true,
        ),
      ),
    );
  }

  @override
  void update(double dt) {
    velocity.x = game.objectSpeed;
    position += velocity * dt;
    if (position.x < -size.x || game.health <= 0) {
      removeFromParent();
    }
    super.update(dt);
  }

  int HP = 2;
  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    if (other is FireBall) {
      if(HP <=0) {
        removeFromParent();
        game.add(WaterExplosion(position: Vector2(position.x, position.y - size.y / 2), onComplete: (){}));
      } else {
        HP = HP -1;
        other.removeFromParent();
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}