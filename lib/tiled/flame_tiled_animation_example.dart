
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/painting.dart';

class FlameTiledAnimationExample extends FlameGame {
  static const String description = '''
    Loads and displays an animated Tiled map.
  ''';

  late final TiledComponent map;

  late JoystickComponent joystick;
  late HudButtonComponent attackButton;
  late HudButtonComponent jumpButton;

  @override
  Future<void> onLoad() async {
    await initJoyStick();

    map = await TiledComponent.load('mymap.tmx', Vector2.all(16));
    //add(map);
    camera.viewfinder.visibleGameSize = Vector2(512, 512);
    camera.viewport.anchor = Anchor.center;
    camera.setBounds(Rectangle.fromLTRB(0, 0, map.size.x, map.size.y));
    world.add(map);

    add(joystick);
    add(jumpButton);
    add(attackButton);
  }

  Future<void> initJoyStick() async {
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
  }


}
