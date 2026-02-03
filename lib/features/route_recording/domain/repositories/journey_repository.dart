import '../models/journey.dart';

abstract class JourneyRepository {
  Future<int> saveJourney(Journey journey);
  Future<void> updateJourney(Journey journey);
  Stream<List<Journey>> watchAllJourneys();
  Future<List<Journey>> getAllJourneys();
  Future<Journey?> getJourneyById(int id);
  Future<void> deleteJourney(int id);
}
