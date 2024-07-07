import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'actors/embernight.dart';
import 'actors/water_enemy.dart';
import 'managers/segment_manager.dart';
import 'objects/ground_block.dart';
import 'objects/platform_block.dart';
import 'objects/star.dart';
import 'overlays/hud.dart';

int defaultHP = 3;

class EmberQuestGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {

  EmberQuestGame();

  late JoystickComponent joystick;
  late HudButtonComponent attackButton;
  late HudButtonComponent jumpButton;
  late EmberNightPlayer _ember;
  late double lastBlockXPosition = 0.0;
  late UniqueKey lastBlockKey;

  int starsCollected = 0;
  int health = defaultHP;
  double cloudSpeed = 0.0;
  double objectSpeed = 0.0;

  @override
  Future<void> onLoad() async {

    // 加载背景音乐
    FlameAudio.bgm.initialize();
    //await FlameAudio.bgm.play('bg_music.ogg', volume: 0.5);

    //debugMode = true; // Uncomment to see the bounding boxes
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
      'layers/enemy.png',
    ]);
    camera.viewfinder.anchor = Anchor.topLeft;
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('layers/bg.png'),
        ParallaxImageData('layers/mountains.png'),
      ],
      baseVelocity: Vector2(0, 0),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 0),
    );
    add(parallax);

    initializeGame(loadHud: true);
  }

  @override
  void update(double dt) {
    if (health <= 0) {
      overlays.add('GameOver');
    }
    super.update(dt);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          add(GroundBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case PlatformBlock:
          add(PlatformBlock(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case Star:
          add(Star(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
        case WaterEnemy:
          add(WaterEnemy(
            gridPosition: block.gridPosition,
            xOffset: xPositionOffset,
          ));
          break;
      }
    }
  }

  Future<void> initializeGame({required bool loadHud}) async {
    // Assume that size.x < 3200
    final segmentsToLoad = (size.x / segmentsWidth).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (segmentsWidth * i).toDouble());
    }

    final image = await images.load('joystick.png');
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 6,
      rows: 1,
    );

    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: sheet.getSpriteById(1),
        size: Vector2.all(75),
      ),
      background: SpriteComponent(
        sprite: sheet.getSpriteById(0),
        size: Vector2.all(125),
      ),
      margin: const EdgeInsets.only(right: 40, bottom: 40),
    );

    final buttonSize = Vector2.all(50);
    jumpButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: sheet.getSpriteById(2),
        size: buttonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: sheet.getSpriteById(4),
        size: buttonSize,
      ),
      margin: const EdgeInsets.only(
        left: 40,
        bottom: 60,
      ),
    );

    // A button with margin from the edge of the viewport that flips the
    // rendering of the player on the Y-axis.
    attackButton = HudButtonComponent(
      button: SpriteComponent(
        sprite: sheet.getSpriteById(3),
        size: buttonSize,
      ),
      buttonDown: SpriteComponent(
        sprite: sheet.getSpriteById(5),
        size: buttonSize,
      ),
      margin: const EdgeInsets.only(
        left: 120,
        bottom: 60,
      ),
    );
    _ember = EmberNightPlayer(joystick, jumpButton, attackButton,
      position: Vector2(32, canvasSize.y - 128),
    );
    world.add(_ember);
    camera.viewport.add(joystick);
    camera.viewport.add(jumpButton);
    camera.viewport.add(attackButton);
    if (loadHud) {
      camera.viewport.add(Hud());
    }
  }

  void reset() {
    starsCollected = 0;
    health = defaultHP;
    lastBlockXPosition = 0;
    initializeGame(loadHud: false);
  }
}
