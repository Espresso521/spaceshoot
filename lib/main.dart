import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'emberquest/ember_quest.dart';
import 'emberquest/overlays/game_over.dart';
import 'emberquest/overlays/main_menu.dart';

bool isMobilePlatform() {
  return !kIsWeb && (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS);
}

void main() {
  runApp(
    GameWidget<EmberQuestGame>.controlled(
      gameFactory: EmberQuestGame.new,
      overlayBuilderMap: {
        if(!isMobilePlatform()) 'MainMenu': (_, game) => MainMenu(game: game),
        'GameOver': (_, game) => GameOver(game: game),
      },
      initialActiveOverlays: !isMobilePlatform() ? const ['MainMenu'] : const [],
    ),
  );
}