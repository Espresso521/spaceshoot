
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class FlameTiledAnimationExample extends FlameGame {
  static const String description = '''
    Loads and displays an animated Tiled map.
  ''';

  late final TiledComponent map;

  @override
  Future<void> onLoad() async {
    map = await TiledComponent.load('mymap.tmx', Vector2.all(16));
    //add(map);
    camera.viewfinder.visibleGameSize = Vector2(512, 512);
    camera.viewport.anchor = Anchor.center;
    camera.setBounds(Rectangle.fromLTRB(0, 0, map.size.x, map.size.y));
    world.add(map);
  }


}
