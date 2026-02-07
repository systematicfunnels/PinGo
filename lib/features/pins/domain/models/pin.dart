import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/domain/models/pin_type.dart';

class Pin {
  final int id;
  final String? title;
  final String? description;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final bool isSynced;
  final ContentVisibility visibility;
  final PinType type;
  final List<String> mediaPaths;
  final int? mapId;
  final int? troupeId;
  final int? journeyId;
  final bool isDraft;

  const Pin({
    required this.id,
    this.title,
    this.description,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    this.isSynced = false,
    this.visibility = ContentVisibility.private,
    this.type = PinType.memory,
    this.mediaPaths = const [],
    this.mapId,
    this.troupeId,
    this.journeyId,
    this.isDraft = false,
  });
}
