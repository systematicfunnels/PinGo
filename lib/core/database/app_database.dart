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
}

class Journeys extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().nullable()();
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

@DriftDatabase(tables: [Pins, Journeys])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.addColumn(pins, pins.visibility);
            await m.addColumn(journeys, journeys.visibility);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'pingo_db');
  }
}
