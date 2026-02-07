import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/features/route_recording/domain/models/journey.dart';

class RouteEntity {
  final int id;
  final String? name;
  final List<List<double>> points;
  final double distanceMeters;
  final int durationSeconds;
  final DateTime createdAt;
  final ContentVisibility visibility;
  final int? sourceJourneyId;

  const RouteEntity({
    required this.id,
    this.name,
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.createdAt,
    this.visibility = ContentVisibility.private,
    this.sourceJourneyId,
  });

  factory RouteEntity.fromJourney(Journey journey) {
    return RouteEntity(
      id: journey.id,
      name: journey.name,
      points: journey.routePoints,
      distanceMeters: journey.totalDistance,
      durationSeconds: journey.durationSeconds,
      createdAt: journey.startTime,
      visibility: journey.visibility,
      sourceJourneyId: journey.id,
    );
  }
}
