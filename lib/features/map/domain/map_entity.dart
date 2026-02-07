import 'package:pingo/core/domain/models/content_visibility.dart';

class UserMap {
  final int id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final bool isSynced;
  final ContentVisibility visibility;
  final String? sourceUrl;
  final String? authorName;

  const UserMap({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    this.isSynced = false,
    this.visibility = ContentVisibility.private,
    this.sourceUrl,
    this.authorName,
  });

  UserMap copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? createdAt,
    bool? isSynced,
    ContentVisibility? visibility,
    String? sourceUrl,
    String? authorName,
  }) {
    return UserMap(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      visibility: visibility ?? this.visibility,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      authorName: authorName ?? this.authorName,
    );
  }
}

class MapPreview {
  final String id;
  final String name;
  final String description;
  final String authorName;
  final int pinCount;
  final int routeCount;
  final String? imageUrl;

  const MapPreview({
    required this.id,
    required this.name,
    required this.description,
    required this.authorName,
    this.pinCount = 0,
    this.routeCount = 0,
    this.imageUrl,
  });
}
