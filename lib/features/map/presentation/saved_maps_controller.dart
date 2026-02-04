import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/features/map/domain/saved_map_model.dart';
import 'package:pingo/features/map/data/repositories/map_repository_impl.dart';

part 'saved_maps_controller.g.dart';

@riverpod
class SavedMapsController extends _$SavedMapsController {
  @override
  Future<List<SavedMapRegion>> build() async {
    final repository = ref.watch(mapRepositoryProvider);
    return repository.getSavedRegions();
  }

  /// Starts a download for the given region.
  /// Returns a Stream of DownloadProgress that the UI can listen to.
  Future<Stream<DownloadProgress>> downloadRegion({
    required String name,
    required LatLngBounds bounds,
    required int minZoom,
    required int maxZoom,
  }) async {
    final repository = ref.read(mapRepositoryProvider);
    return repository.downloadRegion(
      name: name,
      bounds: bounds,
      minZoom: minZoom,
      maxZoom: maxZoom,
    );
  }

  Future<void> deleteRegion(String id) async {
    final repository = ref.read(mapRepositoryProvider);
    await repository.deleteRegion(id);
    // Invalidate the build method to refresh the list
    ref.invalidateSelf();
  }

  Future<void> renameRegion(String id, String newName) async {
    final repository = ref.read(mapRepositoryProvider);
    await repository.renameRegion(id, newName);
    ref.invalidateSelf();
  }
}
