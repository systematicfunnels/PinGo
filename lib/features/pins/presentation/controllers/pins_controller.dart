import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/pin.dart';
import '../../data/repositories/pin_repository_impl.dart';

part 'pins_controller.g.dart';

@riverpod
class PinsController extends _$PinsController {
  @override
  Stream<List<Pin>> build() {
    final repository = ref.watch(pinRepositoryProvider);
    return repository.watchAllPins();
  }

  Future<void> addPin(String title, String description, double lat, double lng,
      {ContentVisibility visibility = ContentVisibility.private}) async {
    final repository = ref.read(pinRepositoryProvider);
    final pin = Pin(
      id: 0, // ID is auto-incremented by DB
      title: title,
      description: description,
      latitude: lat,
      longitude: lng,
      createdAt: DateTime.now(),
      visibility: visibility,
    );
    await repository.createPin(pin);
  }

  Future<void> deletePin(int id) async {
    final repository = ref.read(pinRepositoryProvider);
    await repository.deletePin(id);
  }
}
