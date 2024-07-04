import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_game/emberquest/ember_quest.dart';
import 'package:flame_game/emberquest/managers/segment_manager.dart';


class WaterExplosion extends SpriteAnimationComponent
    with HasGameReference<EmberQuestGame> {
  WaterExplosion({
    super.position,
    required this.onComplete,
  }) : super(
          size: Vector2.all(actorsSize),
          anchor: Anchor.center,
          removeOnFinish: true,
        );

  final VoidCallback onComplete;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'explosion.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if ((animationTicker?.done() ?? false)) {
      onComplete();
    }
  }
}
