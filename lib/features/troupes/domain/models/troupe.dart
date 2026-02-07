import 'package:pingo/core/domain/models/content_visibility.dart';

class Troupe {
  final int id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime createdAt;
  final bool isSynced;
  final ContentVisibility visibility;

  const Troupe({
    required this.id,
    required this.name,
    this.description,
    required this.startDate,
    this.endDate,
    required this.createdAt,
    this.isSynced = false,
    this.visibility = ContentVisibility.private,
  });

  Troupe copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
    bool? isSynced,
    ContentVisibility? visibility,
  }) {
    return Troupe(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      isSynced: isSynced ?? this.isSynced,
      visibility: visibility ?? this.visibility,
    );
  }
}
