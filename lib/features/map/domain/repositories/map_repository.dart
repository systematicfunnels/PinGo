import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:pingo/features/map/domain/saved_map_model.dart';

abstract class MapRepository {
  Future<List<SavedMapRegion>> getSavedRegions();

  Future<Stream<DownloadProgress>> downloadRegion({
    required String name,
    required LatLngBounds bounds,
    required int minZoom,
    required int maxZoom,
  });

  Future<void> deleteRegion(String id);

  Future<void> renameRegion(String id, String newName);
}
