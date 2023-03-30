import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/input.dart';
import 'package:tiled/tiled.dart';

class MainGame extends FlameGame with KeyboardEvents, HasGameRef {
  static const scale = 2.0;
  static const srcTileSize = 64.0;
  static const destTileSize = scale * srcTileSize;

  static const halfSize = true;
  static const tileHeight = scale * (halfSize ? 8.0 : 16.0);

  late IsometricTileMapComponent base;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final tmxData = await assets.readFile('tiles/tile_map.tmx');
    final tmx = TileMapParser.parseTmx(tmxData);
    final matrix = List<List<int>>.generate(tmx.height, (y) => List<int>.filled(tmx.width, 0));
    final tilesetImage = await images.load('tile_map.png');
    final tileset = SpriteSheet(
      image: tilesetImage,
      srcSize: Vector2.all(srcTileSize),
    );

    add(
      base = IsometricTileMapComponent(
        tileset,
        matrix,
        destTileSize: Vector2.all(destTileSize),
        tileHeight: tileHeight,
        position: Vector2(700, 0),
      ),
    );
  }
}