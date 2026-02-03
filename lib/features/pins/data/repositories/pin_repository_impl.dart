import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return _db
        .select(_db.pins)
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<List<domain.Pin>> getAllPins() {
    return _db
        .select(_db.pins)
        .get()
        .then((rows) => rows.map(_toDomain).toList());
  }

  @override
  Future<int> createPin(domain.Pin pin) {
    return _db.into(_db.pins).insert(
          PinsCompanion(
            title: Value(pin.title),
            description: Value(pin.description),
            latitude: Value(pin.latitude),
            longitude: Value(pin.longitude),
            createdAt: Value(pin.createdAt),
            isSynced: Value(pin.isSynced),
            visibility: Value(pin.visibility.index),
          ),
        );
  }

  @override
  Future<void> updatePin(domain.Pin pin) {
    return (_db.update(_db.pins)..where((t) => t.id.equals(pin.id))).write(
      PinsCompanion(
        title: Value(pin.title),
        description: Value(pin.description),
        latitude: Value(pin.latitude),
        longitude: Value(pin.longitude),
        isSynced: Value(pin.isSynced),
        visibility: Value(pin.visibility.index),
      ),
    );
  }

  @override
  Future<void> deletePin(int id) {
    return (_db.delete(_db.pins)..where((t) => t.id.equals(id))).go();
  }

  domain.Pin _toDomain(Pin row) {
    return domain.Pin(
      id: row.id,
      title: row.title,
      description: row.description,
      latitude: row.latitude,
      longitude: row.longitude,
      createdAt: row.createdAt,
      isSynced: row.isSynced,
      visibility: ContentVisibility.values[row.visibility],
    );
  }
}

@riverpod
PinRepository pinRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return PinRepositoryImpl(db);
}
