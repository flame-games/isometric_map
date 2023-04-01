import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'utility/flame_isometric.dart';

class MainGame extends FlameGame with HasGameRef {
  static const scale = 1.0;
  final topLeft = Vector2(600, 0);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final gameSize = gameRef.size;
    final flameIsometric = await FlameIsometric.create(tileMap: 'tile_map.png', tmx: 'tiles/tile_map.tmx');

    for (var i = 0; i < flameIsometric.layerLength; i++) {
      add(
        IsometricTileMapComponent(
          flameIsometric.tileset,
          flameIsometric.matrixList[i],
          destTileSize: flameIsometric.srcTileSize,
          position: Vector2(gameSize.x / 2, flameIsometric.tileHeight.toDouble()),
        ),
      );
    }
  }
}