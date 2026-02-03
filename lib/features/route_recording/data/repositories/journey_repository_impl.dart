import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import '../../../../core/database/app_database.dart' as db;
import '../../../../core/database/database_provider.dart';
import '../../domain/models/journey.dart';
import '../../domain/repositories/journey_repository.dart';

part 'journey_repository_impl.g.dart';

@Riverpod(keepAlive: true)
JourneyRepository journeyRepository(Ref ref) {
  final database = ref.watch(appDatabaseProvider);
  return JourneyRepositoryImpl(database);
}

@riverpod
Future<Journey?> singleJourney(Ref ref, String id) {
  final repository = ref.watch(journeyRepositoryProvider);
  return repository.getJourneyById(int.parse(id));
}

class JourneyRepositoryImpl implements JourneyRepository {
  final db.AppDatabase _db;

  JourneyRepositoryImpl(this._db);

  @override
  Future<int> saveJourney(Journey journey) async {
    final entry = db.JourneysCompanion(
      name: Value(journey.name),
      startTime: Value(journey.startTime),
      endTime: Value(journey.endTime),
      routeData: Value(jsonEncode(journey.routePoints)),
      totalDistance: Value(journey.totalDistance),
      durationSeconds: Value(journey.durationSeconds),
      visibility: Value(journey.visibility.index),
    );
    return await _db.into(_db.journeys).insert(entry);
  }

  @override
  Future<void> updateJourney(Journey journey) async {
    final entry = db.JourneysCompanion(
      name: Value(journey.name),
      startTime: Value(journey.startTime),
      endTime: Value(journey.endTime),
      routeData: Value(jsonEncode(journey.routePoints)),
      totalDistance: Value(journey.totalDistance),
      durationSeconds: Value(journey.durationSeconds),
      visibility: Value(journey.visibility.index),
    );
    await (_db.update(_db.journeys)..where((t) => t.id.equals(journey.id)))
        .write(entry);
  }

  @override
  Stream<List<Journey>> watchAllJourneys() {
    return _db.select(_db.journeys).watch().map((rows) {
      return rows.map((row) => _mapToDomain(row)).toList();
    });
  }

  @override
  Future<List<Journey>> getAllJourneys() async {
    final rows = await _db.select(_db.journeys).get();
    return rows.map((row) => _mapToDomain(row)).toList();
  }

  @override
  Future<Journey?> getJourneyById(int id) async {
    final row = await (_db.select(_db.journeys)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return _mapToDomain(row);
  }

  @override
  Future<void> deleteJourney(int id) async {
    await (_db.delete(_db.journeys)..where((t) => t.id.equals(id))).go();
  }

  Journey _mapToDomain(db.Journey row) {
    List<List<double>> points = [];
    if (row.routeData != null) {
      try {
        final List<dynamic> decoded = jsonDecode(row.routeData!);
        points = decoded.map((e) => List<double>.from(e)).toList();
      } catch (e) {
        // Handle decode error or empty
      }
    }

    return Journey(
      id: row.id,
      name: row.name,
      startTime: row.startTime,
      endTime: row.endTime,
      routePoints: points,
      totalDistance: row.totalDistance,
      durationSeconds: row.durationSeconds,
      visibility: ContentVisibility.values[row.visibility],
    );
  }
}
