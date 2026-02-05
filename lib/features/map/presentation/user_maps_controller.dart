import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/features/map/domain/map_entity.dart';
import 'package:pingo/features/map/data/repositories/user_map_repository_impl.dart';

part 'user_maps_controller.g.dart';

@riverpod
class UserMapsController extends _$UserMapsController {
  @override
  Stream<List<UserMap>> build() {
    final repository = ref.watch(userMapRepositoryProvider);
    return repository.watchUserMaps();
  }

  Future<void> createMap(String name,
      {String? description,
      ContentVisibility visibility = ContentVisibility.private,
      String? sourceUrl,
      String? authorName}) async {
    final repository = ref.read(userMapRepositoryProvider);
    final map = UserMap(
      id: 0,
      name: name,
      description: description,
      createdAt: DateTime.now(),
      visibility: visibility,
      sourceUrl: sourceUrl,
      authorName: authorName,
    );
    await repository.createUserMap(map);
  }

  Future<void> updateMap(UserMap map) async {
    final repository = ref.read(userMapRepositoryProvider);
    await repository.updateUserMap(map);
  }

  Future<void> deleteMap(int id) async {
    final repository = ref.read(userMapRepositoryProvider);
    await repository.deleteUserMap(id);
  }
}
