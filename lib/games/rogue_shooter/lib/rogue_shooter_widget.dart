import 'package:flame/game.dart';
import 'package:flame_game/games/rogue_shooter/lib/rogue_shooter_game.dart';
import 'package:flutter/widgets.dart';

class RogueShooterWidget extends StatelessWidget {
  const RogueShooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: RogueShooterGame(),
      loadingBuilder: (_) => const Center(
        child: Text('Loading'),
      ),
    );
  }
}
