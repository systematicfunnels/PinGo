import '../models/journey.dart';

abstract class JourneyRepository {
  Future<void> saveJourney(Journey journey);
  Future<void> updateJourney(Journey journey);
  Stream<List<Journey>> watchAllJourneys();
  Future<List<Journey>> getAllJourneys();
  Future<void> deleteJourney(int id);
}
