import 'package:pingo/features/troupes/domain/models/troupe.dart';

abstract class TroupeRepository {
  Stream<List<Troupe>> watchTroupes();
  Future<List<Troupe>> getTroupes();
  Future<Troupe?> getTroupe(int id);
  Future<int> createTroupe(Troupe troupe);
  Future<void> updateTroupe(Troupe troupe);
  Future<void> deleteTroupe(int id);
}
