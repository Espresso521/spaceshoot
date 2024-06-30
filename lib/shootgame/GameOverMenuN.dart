import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/text.dart';

class GameOverMenuN extends PositionComponent {
  final VoidCallback onRestart;

  GameOverMenuN({
    required this.onRestart,
  }) : super(
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add "Game Over" text
    final textPaint = TextPaint(
      style: TextStyle(
        color: BasicPalette.white.color,
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
      ),
    );
    final gameOverText = TextComponent(
      text: 'Game Over',
      textRenderer: textPaint,
    );
    gameOverText.position = Vector2(size.x / 2, size.y / 3);
    gameOverText.anchor = Anchor.center;
    add(gameOverText);

    // Add restart button
    final restartButton = HudButtonComponent(
      button: RectangleComponent(
        size: Vector2(200, 50),
        paint: BasicPalette.red.paint(),
      ),
      onPressed: onRestart,
      children: [
        TextComponent(
          text: 'Restart',
          textRenderer: TextPaint(
            style: TextStyle(
              color: BasicPalette.white.color,
              fontSize: 24.0,
            ),
          ),
          anchor: Anchor.center,
          position: Vector2(100, 25),
        ),
      ],
      position: Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
    );

    add(restartButton);
  }
}
