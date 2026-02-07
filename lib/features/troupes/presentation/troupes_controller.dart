import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/features/troupes/domain/models/troupe.dart';
import 'package:pingo/features/troupes/data/repositories/troupe_repository_impl.dart';

part 'troupes_controller.g.dart';

@riverpod
class TroupesController extends _$TroupesController {
  @override
  Stream<List<Troupe>> build() {
    final repository = ref.watch(troupeRepositoryProvider);
    return repository.watchTroupes();
  }

  Future<void> createTroupe(
    String name,
    DateTime startDate, {
    String? description,
    DateTime? endDate,
    ContentVisibility visibility = ContentVisibility.private,
  }) async {
    final repository = ref.read(troupeRepositoryProvider);
    final troupe = Troupe(
      id: 0,
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
      createdAt: DateTime.now(),
      visibility: visibility,
    );
    await repository.createTroupe(troupe);
  }

  Future<void> deleteTroupe(int id) async {
    final repository = ref.read(troupeRepositoryProvider);
    await repository.deleteTroupe(id);
  }
}
