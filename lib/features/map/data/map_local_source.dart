import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/features/map/domain/saved_map_model.dart';

part 'map_local_source.g.dart';

@riverpod
MapLocalSource mapLocalSource(Ref ref) {
  return MapLocalSource();
}

class MapLocalSource {
  Future<List<SavedMapRegion>> getSavedRegions() async {
    try {
      final stores = await FMTCRoot.stats.storesAvailable;
      final regions = <SavedMapRegion>[];

      for (final store in stores) {
        final metadata = await store.metadata.read;
        final name = metadata['name'];
        final boundsStr = metadata['bounds'];
        final createdAtStr = metadata['createdAt'];

        if (name == null || boundsStr == null) continue;

        LatLngBounds? bounds;
        final parts = boundsStr.split(',').map(double.tryParse).toList();
        if (parts.length == 4 && !parts.contains(null)) {
          bounds = LatLngBounds(
            LatLng(parts[0]!, parts[1]!),
            LatLng(parts[2]!, parts[3]!),
          );
        }

        if (bounds == null) continue;

        final size = await store.stats.size;

        regions.add(SavedMapRegion(
          id: store.storeName,
          name: name,
          bounds: bounds,
          sizeBytes: size.toInt(),
          downloadedAt: DateTime.tryParse(createdAtStr ?? '') ?? DateTime.now(),
        ));
      }

      // Sort by newest first
      regions.sort((a, b) => b.downloadedAt.compareTo(a.downloadedAt));

      return regions;
    } catch (e) {
      return [];
    }
  }

  Future<Stream<DownloadProgress>> downloadRegion({
    required String name,
    required LatLngBounds bounds,
    required int minZoom,
    required int maxZoom,
  }) async {
    final storeName = 'region_${DateTime.now().millisecondsSinceEpoch}';
    final store = FMTCStore(storeName);
    await store.manage.create();

    // Save metadata
    await store.metadata.set(key: 'name', value: name);
    await store.metadata.set(
      key: 'bounds',
      value:
          '${bounds.southWest.latitude},${bounds.southWest.longitude},${bounds.northEast.latitude},${bounds.northEast.longitude}',
    );
    await store.metadata
        .set(key: 'createdAt', value: DateTime.now().toIso8601String());

    // Start download
    final result = store.download.startForeground(
      region: RectangleRegion(bounds).toDownloadable(
        minZoom: minZoom,
        maxZoom: maxZoom,
        options: TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.pingo',
        ),
      ),
      skipSeaTiles: true,
      skipExistingTiles: true,
      parallelThreads: 5,
    );

    return result.downloadProgress;
  }

  Future<void> deleteRegion(String id) async {
    final store = FMTCStore(id);
    await store.manage.delete();
  }

  Future<void> renameRegion(String id, String newName) async {
    final store = FMTCStore(id);
    await store.metadata.set(key: 'name', value: newName);
  }
}
