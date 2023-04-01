import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'utility/flame_isometric.dart';

class MainGame extends FlameGame with KeyboardEvents, HasGameRef {
  static const scale = 1.0;
  final topLeft = Vector2(600, 0);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final flameIsometric = await FlameIsometric.create(tileMap: 'tile_map.png', tmx: 'tiles/tile_map.tmx');

    add(
      IsometricTileMapComponent(
        flameIsometric.tileset,
        flameIsometric.matrixList[0],
        destTileSize: flameIsometric.srcTileSize,
        position: topLeft,
      ),
    );

    add(
      IsometricTileMapComponent(
        flameIsometric.tileset,
        flameIsometric.matrixList[1],
        destTileSize: flameIsometric.srcTileSize,
        position: topLeft,
      ),
    );

    add(
      IsometricTileMapComponent(
        flameIsometric.tileset,
        flameIsometric.matrixList[2],
        destTileSize: flameIsometric.srcTileSize,
        position: topLeft,
      ),
    );
  }
}