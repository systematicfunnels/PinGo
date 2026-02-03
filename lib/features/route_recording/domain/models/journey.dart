import 'package:pingo/core/domain/models/content_visibility.dart';

class Journey {
  final int id;
  final String? name;
  final DateTime startTime;
  final DateTime? endTime;
  final List<List<double>> routePoints; // [[lat, lng], [lat, lng]]
  final double totalDistance;
  final int durationSeconds;
  final ContentVisibility visibility;

  Journey({
    required this.id,
    this.name,
    required this.startTime,
    this.endTime,
    required this.routePoints,
    required this.totalDistance,
    required this.durationSeconds,
    this.visibility = ContentVisibility.private,
  });
}
