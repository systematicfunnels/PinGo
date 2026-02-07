import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:pingo/core/database/app_database.dart';
import 'package:pingo/core/database/database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_engine.g.dart';

// Core sync engine interface
abstract class SyncEngine {
  Future<void> sync();
  Future<void> push();
  Future<void> pull();
}

class SyncEngineImpl implements SyncEngine {
  final AppDatabase _db;

  SyncEngineImpl(this._db);

  @override
  Future<void> sync() async {
    // Simple strategy: Push first, then Pull
    await push();
    await pull();
  }

  @override
  Future<void> push() async {
    // 1. Sync Pins
    final unsyncedPins = await (_db.select(_db.pins)
          ..where((t) => t.isSynced.equals(false)))
        .get();
    for (final pin in unsyncedPins) {
      try {
        // TODO: Call API to create/update pin
        // await _api.uploadPin(pin);

        // Mark as synced
        await (_db.update(_db.pins)..where((t) => t.id.equals(pin.id))).write(
          PinsCompanion(isSynced: const Value(true)),
        );
      } catch (e) {
        // Log error, continue to next item
        debugPrint('Failed to sync pin ${pin.id}: $e');
      }
    }

    // 2. Sync Journeys
    final unsyncedJourneys = await (_db.select(_db.journeys)
          ..where((t) => t.isSynced.equals(false)))
        .get();
    for (final journey in unsyncedJourneys) {
      try {
        // TODO: Call API to create/update journey

        // Mark as synced
        await (_db.update(_db.journeys)..where((t) => t.id.equals(journey.id)))
            .write(
          JourneysCompanion(isSynced: const Value(true)),
        );
      } catch (e) {
        debugPrint('Failed to sync journey ${journey.id}: $e');
      }
    }

    // TODO: Sync Troupes, SavedMaps, PinMedias
  }

  @override
  Future<void> pull() async {
    // TODO: Pull remote changes to local
    // 1. Get last sync timestamp
    // 2. Call API with timestamp
    // 3. Insert/Update local DB
  }
}

@Riverpod(keepAlive: true)
SyncEngine syncEngine(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return SyncEngineImpl(db);
}
