import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

class SavedMapRegion {
  final String id;
  final String name;
  final LatLngBounds bounds;
  final int sizeBytes;
  final DateTime downloadedAt;

  SavedMapRegion({
    required this.id,
    required this.name,
    required this.bounds,
    required this.sizeBytes,
    required this.downloadedAt,
  });
}
