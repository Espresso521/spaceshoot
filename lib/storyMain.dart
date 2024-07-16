import 'package:flame/game.dart';
import 'package:flame_game/story/joystick_advanced_example.dart';
import 'package:flame_game/tiled/flame_tiled_animation_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      Column(
        children: [
          SizedBox(
            width: double.infinity,  // 横向填满
            height: 50.0,             // 高度为50px
            child: Container(
              color: Colors.blue,     // 你可以设置一个颜色来测试效果
              // 其他你想要放在SizedBox中的内容
            ),
          ),
          Expanded(
            child: GameWidget(
              game: FlameTiledAnimationExample(),
            ),
          ),
        ],
      )
  );
}
