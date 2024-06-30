import 'package:flame/game.dart';
import 'package:flame_game/shootgame/GameOverMenu.dart';
import 'package:flame_game/shootgame/SpaceShooterGame.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(
    game: SpaceShooterGame(),
    overlayBuilderMap: {
      'GameOverMenu': (context, SpaceShooterGame game) {
        return GameOverMenu(
          onRestart: () {
            game.restartGame(context);
          },
        );
      },
    },
  ));
}
