import 'package:pingo/core/domain/models/content_visibility.dart';

class Pin {
  final int id;
  final String? title;
  final String? description;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final bool isSynced;
  final ContentVisibility visibility;

  const Pin({
    required this.id,
    this.title,
    this.description,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    this.isSynced = false,
    this.visibility = ContentVisibility.private,
  });
}
