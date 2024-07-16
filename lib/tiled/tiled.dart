import 'package:dashbook/dashbook.dart';

import 'package:flame/game.dart';

import '../commons/commons.dart';
import 'flame_tiled_animation_example.dart';

void addTiledStories(Dashbook dashbook) {
  dashbook.storiesOf('Tiled').add(
        'Flame Tiled Animation',
        (_) => GameWidget(game: FlameTiledAnimationExample()),
        codeLink: baseLink('tiled/flame_tiled_animation_example.dart'),
        info: FlameTiledAnimationExample.description,
      );
}
