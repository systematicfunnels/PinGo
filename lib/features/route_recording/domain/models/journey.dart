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

  Journey copyWith({
    int? id,
    String? name,
    DateTime? startTime,
    DateTime? endTime,
    List<List<double>>? routePoints,
    double? totalDistance,
    int? durationSeconds,
    ContentVisibility? visibility,
  }) {
    return Journey(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      routePoints: routePoints ?? this.routePoints,
      totalDistance: totalDistance ?? this.totalDistance,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      visibility: visibility ?? this.visibility,
    );
  }
}
