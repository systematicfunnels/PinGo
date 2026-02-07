import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// Tables
class Pins extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  // 0: Private, 1: Trusted, 2: Public
  IntColumn get visibility => integer().withDefault(const Constant(0))();
  // 0: Memory, 1: Safety, 2: Landmark, etc.
  IntColumn get type => integer().withDefault(const Constant(0))();
  IntColumn get mapId => integer().nullable().references(SavedMaps, #id)();
  IntColumn get troupeId => integer().nullable().references(Troupes, #id)();
  IntColumn get journeyId => integer().nullable().references(Journeys, #id)();
  BoolColumn get isDraft => boolean().withDefault(const Constant(false))();
}

class SavedMaps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  // 0: Private, 1: Trusted, 2: Public
  IntColumn get visibility => integer().withDefault(const Constant(0))();
  TextColumn get sourceUrl => text().nullable()();
  TextColumn get authorName => text().nullable()();
}

class Troupes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  // 0: Private, 1: Trusted, 2: Public
  IntColumn get visibility => integer().withDefault(const Constant(0))();
}

class PinMedias extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get pinId =>
      integer().references(Pins, #id, onDelete: KeyAction.cascade)();
  TextColumn get filePath => text()();
  // 0: Image, 1: Video, 2: Audio
  IntColumn get type => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

class Journeys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  // JSON serialized list of LatLng points
  TextColumn get routeData => text().nullable()();
  // Distance in meters
  RealColumn get totalDistance => real().withDefault(const Constant(0.0))();
  // Duration in seconds
  IntColumn get durationSeconds => integer().withDefault(const Constant(0))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  // 0: Private, 1: Trusted, 2: Public
  IntColumn get visibility => integer().withDefault(const Constant(0))();
}

class JourneyPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get journeyId =>
      integer().references(Journeys, #id, onDelete: KeyAction.cascade)();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get altitude => real().nullable()();
  RealColumn get speed => real().nullable()();
  RealColumn get accuracy => real().nullable()();
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
    tables: [Pins, Journeys, SavedMaps, Troupes, PinMedias, JourneyPoints])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // Create indexes
          await m.createIndex(Index('pins_map_id_idx',
              'CREATE INDEX IF NOT EXISTS pins_map_id_idx ON pins (map_id)'));
          await m.createIndex(Index('pins_troupe_id_idx',
              'CREATE INDEX IF NOT EXISTS pins_troupe_id_idx ON pins (troupe_id)'));
          await m.createIndex(Index('pins_journey_id_idx',
              'CREATE INDEX IF NOT EXISTS pins_journey_id_idx ON pins (journey_id)'));
          await m.createIndex(Index('journey_points_journey_id_idx',
              'CREATE INDEX IF NOT EXISTS journey_points_journey_id_idx ON journey_points (journey_id)'));
          await m.createIndex(Index('pin_medias_pin_id_idx',
              'CREATE INDEX IF NOT EXISTS pin_medias_pin_id_idx ON pin_medias (pin_id)'));
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Helper to safely add columns (ignores "duplicate column" errors)
          Future<void> addColumnSafe(
              TableInfo table, GeneratedColumn column) async {
            try {
              await m.addColumn(table, column);
            } catch (e) {
              if (!e.toString().contains('duplicate column name')) {
                rethrow;
              }
            }
          }

          if (from < 2) {
            await addColumnSafe(pins, pins.visibility);
            await addColumnSafe(journeys, journeys.visibility);
          }
          if (from < 3) {
            await addColumnSafe(pins, pins.type);
          }
          if (from < 4) {
            await m.createTable(savedMaps);
            await m.createTable(troupes);
            await m.createTable(pinMedias);
          }
          if (from < 5) {
            await addColumnSafe(pins, pins.mapId);
            await addColumnSafe(pins, pins.troupeId);
          }
          if (from < 6) {
            await m.createTable(journeyPoints);
            await addColumnSafe(pins, pins.journeyId);
          }
          if (from < 7) {
            await addColumnSafe(savedMaps, savedMaps.sourceUrl);
            await addColumnSafe(savedMaps, savedMaps.authorName);
          }
          if (from < 8) {
            await addColumnSafe(journeys, journeys.description);
          }
          if (from < 9) {
            // Create indexes for foreign keys
            await m.createIndex(Index('pins_map_id_idx',
                'CREATE INDEX IF NOT EXISTS pins_map_id_idx ON pins (map_id)'));
            await m.createIndex(Index('pins_troupe_id_idx',
                'CREATE INDEX IF NOT EXISTS pins_troupe_id_idx ON pins (troupe_id)'));
            await m.createIndex(Index('pins_journey_id_idx',
                'CREATE INDEX IF NOT EXISTS pins_journey_id_idx ON pins (journey_id)'));
            await m.createIndex(Index('journey_points_journey_id_idx',
                'CREATE INDEX IF NOT EXISTS journey_points_journey_id_idx ON journey_points (journey_id)'));
            await m.createIndex(Index('pin_medias_pin_id_idx',
                'CREATE INDEX IF NOT EXISTS pin_medias_pin_id_idx ON pin_medias (pin_id)'));
          }
          if (from < 10) {
            await addColumnSafe(pins, pins.isDraft);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'pingo_db');
  }
}
