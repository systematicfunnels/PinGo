import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/features/map/data/map_local_source.dart';
import 'package:pingo/features/map/domain/repositories/map_repository.dart';
import 'package:pingo/features/map/domain/saved_map_model.dart';

part 'map_repository_impl.g.dart';

@riverpod
MapRepository mapRepository(Ref ref) {
  final localSource = ref.watch(mapLocalSourceProvider);
  return MapRepositoryImpl(localSource);
}

class MapRepositoryImpl implements MapRepository {
  final MapLocalSource _localSource;

  MapRepositoryImpl(this._localSource);

  @override
  Future<List<SavedMapRegion>> getSavedRegions() =>
      _localSource.getSavedRegions();

  @override
  Future<Stream<DownloadProgress>> downloadRegion({
    required String name,
    required LatLngBounds bounds,
    required int minZoom,
    required int maxZoom,
  }) =>
      _localSource.downloadRegion(
        name: name,
        bounds: bounds,
        minZoom: minZoom,
        maxZoom: maxZoom,
      );

  @override
  Future<void> deleteRegion(String id) => _localSource.deleteRegion(id);

  @override
  Future<void> renameRegion(String id, String newName) =>
      _localSource.renameRegion(id, newName);
}
