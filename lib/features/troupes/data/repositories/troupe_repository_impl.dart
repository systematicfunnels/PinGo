import 'package:drift/drift.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/core/database/app_database.dart';
import 'package:pingo/core/database/database_provider.dart';
import 'package:pingo/features/troupes/domain/models/troupe.dart' as domain;
import 'package:pingo/features/troupes/domain/repositories/troupe_repository.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';

part 'troupe_repository_impl.g.dart';

@riverpod
TroupeRepository troupeRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return TroupeRepositoryImpl(db);
}

class TroupeRepositoryImpl implements TroupeRepository {
  final AppDatabase _db;

  TroupeRepositoryImpl(this._db);

  @override
  Stream<List<domain.Troupe>> watchTroupes() {
    return _db.select(_db.troupes).watch().map((rows) {
      return rows.map((row) => _toDomain(row)).toList();
    });
  }

  @override
  Future<List<domain.Troupe>> getTroupes() async {
    final rows = await _db.select(_db.troupes).get();
    return rows.map((row) => _toDomain(row)).toList();
  }

  @override
  Future<domain.Troupe?> getTroupe(int id) async {
    final query = _db.select(_db.troupes)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    return row != null ? _toDomain(row) : null;
  }

  @override
  Future<int> createTroupe(domain.Troupe troupe) {
    return _db.into(_db.troupes).insert(
          TroupesCompanion(
            name: Value(troupe.name),
            description: Value(troupe.description),
            startDate: Value(troupe.startDate),
            endDate: Value(troupe.endDate),
            createdAt: Value(troupe.createdAt),
            isSynced: Value(troupe.isSynced),
            visibility: Value(troupe.visibility.index),
          ),
        );
  }

  @override
  Future<void> updateTroupe(domain.Troupe troupe) {
    return (_db.update(_db.troupes)..where((tbl) => tbl.id.equals(troupe.id)))
        .write(
      TroupesCompanion(
        name: Value(troupe.name),
        description: Value(troupe.description),
        startDate: Value(troupe.startDate),
        endDate: Value(troupe.endDate),
        isSynced: Value(troupe.isSynced),
        visibility: Value(troupe.visibility.index),
      ),
    );
  }

  @override
  Future<void> deleteTroupe(int id) {
    return (_db.delete(_db.troupes)..where((tbl) => tbl.id.equals(id))).go();
  }

  domain.Troupe _toDomain(Troupe row) {
    return domain.Troupe(
      id: row.id,
      name: row.name,
      description: row.description,
      startDate: row.startDate,
      endDate: row.endDate,
      createdAt: row.createdAt,
      isSynced: row.isSynced,
      visibility: ContentVisibility.values[row.visibility],
    );
  }
}
