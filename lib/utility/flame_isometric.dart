import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:tiled/tiled.dart';

class FlameIsometric extends FlameGame {
  late String tmx;
  late String tileMap;
  
  late List<List<List<int>>> matrixList = [];
  late SpriteSheet tileset;

  late Vector2 srcTileSize;
  late int tileWidth;
  late int tileHeight;
  late int layerLength = 0;

  FlameIsometric._();

  static Future<FlameIsometric> create({required String tmx, required String tileMap}) async {
    var flameIsometric = FlameIsometric._();
    flameIsometric.tmx = tmx;
    flameIsometric.tileMap = tileMap;
    return flameIsometric._init();
  }

  Future<FlameIsometric> _init() async {
    final tmxData = await assets.readFile(this.tmx);
    final tmx = TileMapParser.parseTmx(tmxData);
    final layers = tmx.layers.whereType<TileLayer>();
    layerLength = layers.length;
    matrixList = getMatrixList(layers);

    final tilesetImage = await images.load(tileMap);
    tileWidth = tmx.tileWidth;
    tileHeight = tmx.tileHeight;
    srcTileSize = Vector2(tileWidth.toDouble(), tileWidth.toDouble());

    tileset = SpriteSheet(
      image: tilesetImage,
      srcSize: srcTileSize,
    );
    return this;
  }

  List<List<int>> getSpriteSheetMatrix(layer) {
    return List<List<int>>.generate(layer.height, (row) => List.generate(layer.width, (col) => layer.data != null ? layer.data[row * layer.width + col] - 1 : -1),);
  }

  List<List<List<int>>> getMatrixList(layers) {
    late List<List<List<int>>> matrixList = [];
    layers.forEach((layer) => {
      matrixList.add(getSpriteSheetMatrix(layer))
    });
    return matrixList;
  }
}