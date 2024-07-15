import 'package:flame/game.dart';
import 'package:flame_game/games/trex/lib/trex_game.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(
    GameWidget(game: TRexGame()),
  );
}
