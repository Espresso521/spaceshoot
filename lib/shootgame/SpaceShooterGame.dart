import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

import 'Boss.dart';
import 'Enemy.dart';
import 'GameOverMenuN.dart';
import 'Player.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Player player;

  @override
  Future<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('stars_0.png'),
        ParallaxImageData('stars_1.png'),
        ParallaxImageData('stars_2.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 5),
    );
    add(parallax);

    player = Player();
    add(player);

    add(
      SpawnComponent(
        factory: (index) {
          return Enemy();
        },
        period: 0.5,
        area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
      ),
    );

    add(
      SpawnComponent(
        factory: (index) {
          return Boss();
        },
        period: 30,
        area: Rectangle.fromLTWH(0, 0, size.x, -Boss.enemySize),
      ),
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
  }

  void showGameOverMenu(BuildContext context) {
    overlays.add('GameOverMenu');
  }

  void restartGame(BuildContext context) {
    overlays.remove('GameOverMenu');
    remove(player);
    player = Player();
    add(player);
  }

  void showGameOverMenuN() {
    final gameOverMenu = GameOverMenuN(
      onRestart: restartGameN,
    )..position = size / 2;
    add(gameOverMenu);
  }

  void restartGameN() {
    removeWhere((component) => component is GameOverMenuN);
    remove(player);
    player = Player();
    add(player);
  }
}


