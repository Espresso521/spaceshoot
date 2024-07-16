import 'package:dashbook/dashbook.dart';
import 'package:flame_game/parallax/parallax.dart';
import 'package:flame_game/rendering/rendering.dart';
import 'package:flame_game/tiled/tiled.dart';
import 'package:flutter/material.dart';

import 'camera_and_viewport/camera_and_viewport.dart';
import 'games/gamesbook.dart';

void main() {
  final dashbook = Dashbook();
  //addCameraAndViewportStories(dashbook);
  //addGameStories(dashbook);
  //addRenderingStories(dashbook);
  //addTiledStories(dashbook);
  addParallaxStories(dashbook);
  runApp(dashbook);
}
