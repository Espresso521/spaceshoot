import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';

import '../ember_quest.dart';
import '../managers/segment_manager.dart';
import 'fireball.dart';

class PlatformBlock extends SpriteComponent
    with HasGameReference<EmberQuestGame>, CollisionCallbacks {
  final Vector2 gridPosition;
  double xOffset;

  final Vector2 velocity = Vector2.zero();

  PlatformBlock({
    required this.gridPosition,
    required this.xOffset,
  }) : super(size: Vector2.all(actorsSize), anchor: Anchor.bottomLeft);

  @override
  Future<void> onLoad() async {
    final platformImage = game.images.fromCache('block.png');
    sprite = Sprite(platformImage);
    position = Vector2(
      (gridPosition.x * size.x) + xOffset,
      game.size.y - (gridPosition.y * size.y),
    );
    add(RectangleHitbox());
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

  bool isVibrate = false;

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is FireBall) {
      if (!isVibrate) {
        isVibrate = true;
        add(SizeEffect.by(
            Vector2(-1, -1),
            EffectController(
              duration: 0.1,
              reverseDuration: 0.1,
              infinite: false,
            ))
          ..onComplete = () {
          isVibrate = false;
          });
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
