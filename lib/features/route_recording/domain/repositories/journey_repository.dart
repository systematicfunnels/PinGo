import '../models/journey.dart';

abstract class JourneyRepository {
  Future<int> saveJourney(Journey journey);
  Future<void> insertJourneyPoint(int journeyId, double lat, double lng,
      {double? alt, double? speed, double? accuracy, DateTime? timestamp});
  Future<void> updateJourney(Journey journey);
  Stream<List<Journey>> watchAllJourneys();
  Future<List<Journey>> getAllJourneys();
  Future<Journey?> getJourneyById(int id);
  Future<Journey?> getActiveJourney();
  Future<List<List<double>>> getJourneyRoutePoints(int journeyId);
  Future<void> deleteJourney(int id);
}
