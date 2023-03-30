import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/input.dart';
import 'package:tiled/tiled.dart';

class MainGame extends FlameGame with KeyboardEvents, HasGameRef {
  static const scale = 1.0;
  static const srcTileSize = 64.0;
  static const destTileSize = scale * srcTileSize;

  static const halfSize = true;
  static const tileHeight = scale * (halfSize ? 8.0 : 16.0);

  late IsometricTileMapComponent base;

  final topLeft = Vector2(600, 0);

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final tmxData = await assets.readFile('tiles/tile_map.tmx');
    final tmx = TileMapParser.parseTmx(tmxData);
    // final tilesets = tmx.tilesets;
    final layers = tmx.layers.whereType<TileLayer>();
    // final tileSize = tmx.tileWidth.toDouble();
    final mapWidth = layers.first.width;
    final mapHeight = layers.first.height;

    final data = layers.first.data;

    final matrix = List<List<int>>.generate(mapHeight, (row) => List.generate(mapWidth, (col) => data![row * mapWidth + col]),);

    // for (final layer in tmx.layers) {
    //   if (layer is TileLayer) {
    //     for (var y = 0; y < tmx.height; y++) {
    //       for (var x = 0; x < tmx.width; x++) {
    //         final index = layer.tiles[x + y * tmx.width].tileId;
    //         matrix[y][x] = index;
    //       }
    //     }
    //   }
    // }

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
        position: topLeft,
      ),
    );
  }
}