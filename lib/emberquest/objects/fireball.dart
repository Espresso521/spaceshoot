import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_game/emberquest/ember_quest.dart';


class FireBall extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame> {
  FireBall({
    super.position,
  }) : super(
    size: Vector2(28, 28),
    anchor: Anchor.center,
  ){
    initialX = position.x; // 记录初始位置
  }

  late double initialX; // 记录子弹的初始位置

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
    position.x += dt * 200;
    // 检查子弹是否飞行了200个单位
    if (position.x - initialX >= 125) {
      removeFromParent(); // 移除子弹
    }
  }
}

