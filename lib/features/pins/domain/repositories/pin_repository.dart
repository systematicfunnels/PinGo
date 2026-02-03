import '../models/pin.dart';

abstract class PinRepository {
  Stream<List<Pin>> watchAllPins();
  Future<List<Pin>> getAllPins();
  Future<int> createPin(Pin pin);
  Future<void> updatePin(Pin pin);
  Future<void> deletePin(int id);
}
