import 'package:pingo/features/map/data/repositories/user_map_repository_impl.dart';
import 'package:pingo/features/map/domain/map_entity.dart';
import 'package:pingo/features/pins/data/repositories/pin_repository_impl.dart';
import 'package:pingo/features/pins/domain/models/pin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'explore_search_controller.g.dart';

// --- Domain Models for Search ---

sealed class ExploreSearchResult {
  final String title;
  final String subtitle;

  const ExploreSearchResult({required this.title, required this.subtitle});
}

class PinSearchResult extends ExploreSearchResult {
  final Pin pin;

  PinSearchResult({required this.pin})
      : super(
            title: pin.title ?? 'Untitled Pin',
            subtitle: pin.description ?? 'Pin');
}

class MapSearchResult extends ExploreSearchResult {
  final UserMap map;

  MapSearchResult({required this.map})
      : super(title: map.name, subtitle: map.description ?? 'Map');
}

// --- Providers ---

@riverpod
class ExploreSearchQuery extends _$ExploreSearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }
}

@riverpod
Future<List<ExploreSearchResult>> exploreSearchResults(Ref ref) async {
  final query = ref.watch(exploreSearchQueryProvider);

  // Return empty list if query is too short
  if (query.length < 2) return [];

  final lowerQuery = query.toLowerCase();

  // Fetch data (simulated search by filtering all items)
  // In a real app, use repository search methods
  final pins = await ref.watch(pinRepositoryProvider).getAllPins();
  final maps = await ref.watch(userMapRepositoryProvider).getUserMaps();

  final List<ExploreSearchResult> results = [];

  // Filter Pins
  for (final pin in pins) {
    final title = pin.title?.toLowerCase() ?? '';
    final description = pin.description?.toLowerCase() ?? '';

    if (title.contains(lowerQuery) || description.contains(lowerQuery)) {
      results.add(PinSearchResult(pin: pin));
    }
  }

  // Filter Maps
  for (final map in maps) {
    if (map.name.toLowerCase().contains(lowerQuery) ||
        (map.description?.toLowerCase().contains(lowerQuery) ?? false)) {
      results.add(MapSearchResult(map: map));
    }
  }

  return results;
}
