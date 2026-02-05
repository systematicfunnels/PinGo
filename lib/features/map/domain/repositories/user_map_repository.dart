import 'package:pingo/features/map/domain/map_entity.dart';

abstract class UserMapRepository {
  Stream<List<UserMap>> watchUserMaps();
  Future<List<UserMap>> getUserMaps();
  Future<UserMap?> getUserMap(int id);
  Future<int> createUserMap(UserMap map);
  Future<void> updateUserMap(UserMap map);
  Future<void> deleteUserMap(int id);
}
