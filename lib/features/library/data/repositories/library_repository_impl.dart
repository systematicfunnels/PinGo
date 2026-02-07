import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/features/pins/domain/repositories/pin_repository.dart';
import 'package:pingo/features/pins/data/repositories/pin_repository_impl.dart';
import 'package:pingo/features/map/domain/repositories/user_map_repository.dart';
import 'package:pingo/features/map/data/repositories/user_map_repository_impl.dart';
import 'package:pingo/features/route_recording/domain/repositories/journey_repository.dart';
import 'package:pingo/features/route_recording/data/repositories/journey_repository_impl.dart';
import 'package:pingo/features/map/domain/repositories/map_repository.dart';
import 'package:pingo/features/map/data/repositories/map_repository_impl.dart';

import '../../domain/models/library_search_result.dart';
import '../../domain/models/library_stats.dart';
import '../../domain/repositories/library_repository.dart';

part 'library_repository_impl.g.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final PinRepository _pinRepository;
  final UserMapRepository _userMapRepository;
  final JourneyRepository _journeyRepository;
  final MapRepository _mapRepository;

  LibraryRepositoryImpl(
    this._pinRepository,
    this._userMapRepository,
    this._journeyRepository,
    this._mapRepository,
  );

  @override
  Future<LibraryStats> getStats() async {
    final pins = await _pinRepository.getAllPins();
    final maps = await _userMapRepository.getUserMaps();
    final journeys = await _journeyRepository.getAllJourneys();
    final offlineRegions = await _mapRepository.getSavedRegions();

    return LibraryStats(
      pinCount: pins.length,
      mapCount: maps.length,
      journeyCount: journeys.length,
      offlineMapCount: offlineRegions.length,
    );
  }

  @override
  Future<LibrarySearchResult> search(String query) async {
    if (query.trim().isEmpty) {
      return const LibrarySearchResult();
    }

    final lowercaseQuery = query.toLowerCase();

    // Fetch all data
    // TODO: Optimize by implementing search at DB level
    final pins = await _pinRepository.getAllPins();
    final maps = await _userMapRepository.getUserMaps();
    final journeys = await _journeyRepository.getAllJourneys();
    final offlineRegions = await _mapRepository.getSavedRegions();

    // Filter
    final filteredPins = pins.where((pin) {
      return (pin.title?.toLowerCase().contains(lowercaseQuery) ?? false) ||
          (pin.description?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();

    final filteredMaps = maps.where((map) {
      return map.name.toLowerCase().contains(lowercaseQuery) ||
          (map.description?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();

    final filteredJourneys = journeys.where((journey) {
      return (journey.name?.toLowerCase().contains(lowercaseQuery) ?? false) ||
          (journey.description?.toLowerCase().contains(lowercaseQuery) ??
              false);
    }).toList();

    final filteredRegions = offlineRegions.where((region) {
      return region.name.toLowerCase().contains(lowercaseQuery);
    }).toList();

    return LibrarySearchResult(
      pins: filteredPins,
      maps: filteredMaps,
      journeys: filteredJourneys,
      offlineRegions: filteredRegions,
    );
  }
}

@riverpod
LibraryRepository libraryRepository(Ref ref) {
  final pinRepository = ref.watch(pinRepositoryProvider);
  final userMapRepository = ref.watch(userMapRepositoryProvider);
  final journeyRepository = ref.watch(journeyRepositoryProvider);
  final mapRepository = ref.watch(mapRepositoryProvider);

  return LibraryRepositoryImpl(
    pinRepository,
    userMapRepository,
    journeyRepository,
    mapRepository,
  );
}
