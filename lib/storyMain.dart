import 'package:flame/game.dart';
import 'package:flame_game/story/joystick_advanced_example.dart';
import 'package:flame_game/tiled/flame_tiled_animation_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(
    game: FlameTiledAnimationExample(),
  ));
}
