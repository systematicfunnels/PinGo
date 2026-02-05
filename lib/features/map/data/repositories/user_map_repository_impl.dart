import 'package:drift/drift.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/core/database/app_database.dart';
import 'package:pingo/core/database/database_provider.dart';
import 'package:pingo/features/map/domain/map_entity.dart';
import 'package:pingo/features/map/domain/repositories/user_map_repository.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';

part 'user_map_repository_impl.g.dart';

@riverpod
UserMapRepository userMapRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return UserMapRepositoryImpl(db);
}

class UserMapRepositoryImpl implements UserMapRepository {
  final AppDatabase _db;

  UserMapRepositoryImpl(this._db);

  @override
  Stream<List<UserMap>> watchUserMaps() {
    return _db.select(_db.savedMaps).watch().map((rows) {
      return rows.map((row) => _toDomain(row)).toList();
    });
  }

  @override
  Future<List<UserMap>> getUserMaps() async {
    final rows = await _db.select(_db.savedMaps).get();
    return rows.map((row) => _toDomain(row)).toList();
  }

  @override
  Future<UserMap?> getUserMap(int id) async {
    final query = _db.select(_db.savedMaps)..where((tbl) => tbl.id.equals(id));
    final row = await query.getSingleOrNull();
    return row != null ? _toDomain(row) : null;
  }

  @override
  Future<int> createUserMap(UserMap map) {
    return _db.into(_db.savedMaps).insert(
          SavedMapsCompanion(
            name: Value(map.name),
            description: Value(map.description),
            createdAt: Value(map.createdAt),
            isSynced: Value(map.isSynced),
            visibility: Value(map.visibility.index),
            sourceUrl: Value(map.sourceUrl),
            authorName: Value(map.authorName),
          ),
        );
  }

  @override
  Future<void> updateUserMap(UserMap map) {
    return (_db.update(_db.savedMaps)..where((tbl) => tbl.id.equals(map.id)))
        .write(
      SavedMapsCompanion(
        name: Value(map.name),
        description: Value(map.description),
        isSynced: Value(map.isSynced),
        visibility: Value(map.visibility.index),
        sourceUrl: Value(map.sourceUrl),
        authorName: Value(map.authorName),
      ),
    );
  }

  @override
  Future<void> deleteUserMap(int id) {
    return (_db.delete(_db.savedMaps)..where((tbl) => tbl.id.equals(id))).go();
  }

  UserMap _toDomain(SavedMap row) {
    return UserMap(
      id: row.id,
      name: row.name,
      description: row.description,
      createdAt: row.createdAt,
      isSynced: row.isSynced,
      visibility: ContentVisibility.values[row.visibility],
      sourceUrl: row.sourceUrl,
      authorName: row.authorName,
    );
  }
}
