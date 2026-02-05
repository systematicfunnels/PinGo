import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/domain/models/pin_type.dart';
import 'package:drift/drift.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../domain/models/pin.dart' as domain;
import '../../domain/repositories/pin_repository.dart';

part 'pin_repository_impl.g.dart';

class PinRepositoryImpl implements PinRepository {
  final AppDatabase _db;

  PinRepositoryImpl(this._db);

  @override
  Stream<List<domain.Pin>> watchAllPins() {
    return _db.select(_db.pins).watch().asyncMap((rows) async {
      if (rows.isEmpty) return [];

      final pinIds = rows.map((r) => r.id).toList();
      final mediaRows = await (_db.select(_db.pinMedias)
            ..where((t) => t.pinId.isIn(pinIds)))
          .get();

      final mediaMap = <int, List<String>>{};
      for (final m in mediaRows) {
        mediaMap.putIfAbsent(m.pinId, () => []).add(m.filePath);
      }

      return rows
          .map((row) => _toDomain(row, mediaPaths: mediaMap[row.id] ?? []))
          .toList();
    });
  }

  @override
  Future<List<domain.Pin>> getAllPins() async {
    final rows = await _db.select(_db.pins).get();
    if (rows.isEmpty) return [];

    final pinIds = rows.map((r) => r.id).toList();
    final mediaRows = await (_db.select(_db.pinMedias)
          ..where((t) => t.pinId.isIn(pinIds)))
        .get();

    final mediaMap = <int, List<String>>{};
    for (final m in mediaRows) {
      mediaMap.putIfAbsent(m.pinId, () => []).add(m.filePath);
    }

    return rows
        .map((row) => _toDomain(row, mediaPaths: mediaMap[row.id] ?? []))
        .toList();
  }

  @override
  Future<int> createPin(domain.Pin pin) {
    return _db.transaction(() async {
      final id = await _db.into(_db.pins).insert(
            PinsCompanion(
              title: Value(pin.title),
              description: Value(pin.description),
              latitude: Value(pin.latitude),
              longitude: Value(pin.longitude),
              createdAt: Value(pin.createdAt),
              isSynced: Value(pin.isSynced),
              visibility: Value(pin.visibility.index),
              type: Value(pin.type.index),
              mapId: Value(pin.mapId),
              troupeId: Value(pin.troupeId),
              journeyId: Value(pin.journeyId),
              isDraft: Value(pin.isDraft),
            ),
          );

      if (pin.mediaPaths.isNotEmpty) {
        for (final path in pin.mediaPaths) {
          await _db.into(_db.pinMedias).insert(
                PinMediasCompanion(
                  pinId: Value(id),
                  filePath: Value(path),
                  type: const Value(0), // Default to image
                ),
              );
        }
      }
      return id;
    });
  }

  @override
  Future<void> updatePin(domain.Pin pin) {
    return _db.transaction(() async {
      // 1. Update Pin details
      await (_db.update(_db.pins)..where((t) => t.id.equals(pin.id))).write(
        PinsCompanion(
          title: Value(pin.title),
          description: Value(pin.description),
          latitude: Value(pin.latitude),
          longitude: Value(pin.longitude),
          isSynced: Value(pin.isSynced),
          visibility: Value(pin.visibility.index),
          type: Value(pin.type.index),
          mapId: Value(pin.mapId),
          troupeId: Value(pin.troupeId),
          journeyId: Value(pin.journeyId),
          isDraft: Value(pin.isDraft),
        ),
      );

      // 2. Sync Media: Delete old, Insert new
      await (_db.delete(_db.pinMedias)..where((t) => t.pinId.equals(pin.id)))
          .go();

      if (pin.mediaPaths.isNotEmpty) {
        await _db.batch((batch) {
          batch.insertAll(
              _db.pinMedias,
              pin.mediaPaths.map((path) =>
                  PinMediasCompanion.insert(pinId: pin.id, filePath: path)));
        });
      }
    });
  }

  @override
  Future<void> deletePin(int id) {
    return (_db.delete(_db.pins)..where((t) => t.id.equals(id))).go();
  }

  domain.Pin _toDomain(Pin row, {List<String> mediaPaths = const []}) {
    return domain.Pin(
      id: row.id,
      title: row.title,
      description: row.description,
      latitude: row.latitude,
      longitude: row.longitude,
      createdAt: row.createdAt,
      isSynced: row.isSynced,
      visibility: ContentVisibility.values[row.visibility],
      type: PinType.values[row.type],
      mediaPaths: mediaPaths,
      mapId: row.mapId,
      troupeId: row.troupeId,
      journeyId: row.journeyId,
      isDraft: row.isDraft,
    );
  }
}

@riverpod
PinRepository pinRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return PinRepositoryImpl(db);
}
