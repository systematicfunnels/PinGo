import 'package:pingo/features/pins/domain/models/pin.dart';
import 'package:pingo/features/map/domain/map_entity.dart';
import 'package:pingo/features/route_recording/domain/models/journey.dart';
import 'package:pingo/features/map/domain/saved_map_model.dart';

class LibrarySearchResult {
  final List<Pin> pins;
  final List<UserMap> maps;
  final List<Journey> journeys;
  final List<SavedMapRegion> offlineRegions;

  const LibrarySearchResult({
    this.pins = const [],
    this.maps = const [],
    this.journeys = const [],
    this.offlineRegions = const [],
  });

  bool get isEmpty =>
      pins.isEmpty && maps.isEmpty && journeys.isEmpty && offlineRegions.isEmpty;
}
