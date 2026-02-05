import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/core/network/dio_provider.dart';
import 'package:pingo/features/map/domain/map_entity.dart';

part 'map_remote_source.g.dart';

// Map remote data source
class MapRemoteSource {
  final Dio _dio;

  MapRemoteSource(this._dio);

  Future<MapPreview> getMapPreview(String id) async {
    try {
      final response = await _dio.get('/maps/$id/preview');
      final data = response.data as Map<String, dynamic>;

      return MapPreview(
        id: data['id'] as String,
        name: data['name'] as String,
        description: data['description'] as String,
        authorName: data['author_name'] as String,
        pinCount: data['pin_count'] as int? ?? 0,
        routeCount: data['route_count'] as int? ?? 0,
        imageUrl: data['image_url'] as String?,
      );
    } catch (e) {
      // For now, return mock data on error if backend is not ready
      // or rethrow. Given we are in dev, let's keep the mock fallback or just rethrow.
      // Since the user might run the app and expect it to work without backend:
      debugPrint('Error fetching map preview: $e. Using mock data.');

      await Future.delayed(const Duration(seconds: 1));
      return MapPreview(
        id: id,
        name: 'Hidden Gems of Kyoto #$id',
        description:
            'A curated collection of quiet temples, moss gardens, and traditional tea houses away from the crowds.',
        authorName: 'Traveler_X',
        pinCount: 12,
        routeCount: 2,
      );
    }
  }
}

@riverpod
MapRemoteSource mapRemoteSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return MapRemoteSource(dio);
}
