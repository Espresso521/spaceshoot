import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_game/emberquest/ember_quest.dart';

class FireBall extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame> {
  int orientation = 1;

  FireBall(this.orientation, {
    super.position,
  }) : super(
    size: Vector2(25, 25),
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
    if(orientation == -1) {
      position.x -= dt * 200;
    } else {
      position.x += dt * 200;
    }
    // 检查子弹是否飞行了200个单位
    if ((position.x - initialX).abs() >= 125) {
      removeFromParent(); // 移除子弹
    }
  }
}

