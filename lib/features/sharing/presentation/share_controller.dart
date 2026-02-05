import 'package:pingo/features/route_recording/domain/models/journey.dart';
import 'package:pingo/features/map/domain/map_entity.dart';
import 'package:pingo/features/pins/domain/models/pin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/features/sharing/data/repositories/share_repository_impl.dart';
import 'package:pingo/features/sharing/domain/visibility_rules.dart';

part 'share_controller.g.dart';

@riverpod
class ShareController extends _$ShareController {
  @override
  FutureOr<void> build() {
    // No initial state needed
  }

  Future<void> sharePin(Pin pin) async {
    if (!VisibilityRules.canShare(pin.visibility)) {
      state = AsyncValue.error(
        'Cannot share private content. Change visibility first.',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(shareRepositoryProvider);

      final String link = 'https://pingo.app/pin/${pin.id}';
      final String text = 'Check out "${pin.title ?? 'this memory'}" on PinGo!\n'
          '${pin.description ?? ''}';

      await repository.shareUrl(url: link, message: text);
    });
  }

  Future<String> generatePinLink(Pin pin) async {
     return 'https://pingo.app/pin/${pin.id}';
  }

  Future<void> shareJourney(Journey journey) async {
    if (!VisibilityRules.canShare(journey.visibility)) {
      state = AsyncValue.error(
        'Cannot share private content',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(shareRepositoryProvider);

      // In a real app, we would generate a deep link here.
      // For now, we simulate a link.
      final String link = 'https://pingo.app/journey/${journey.id}';

      final String duration = _formatDuration(journey.durationSeconds);
      final String distance = (journey.totalDistance / 1000).toStringAsFixed(1);

      final String text =
          'Check out my journey "${journey.name ?? 'Untitled'}" on PinGo!\n'
          'Distance: ${distance}km\n'
          'Duration: $duration';

      await repository.shareUrl(url: link, message: text);
    });
  }

  Future<void> shareMap(UserMap map) async {
    if (!VisibilityRules.canShare(map.visibility)) {
      state = AsyncValue.error(
        'Cannot share private content',
        StackTrace.current,
      );
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(shareRepositoryProvider);

      final String link = 'https://pingo.app/map/${map.id}';

      final String text = 'Check out my map "${map.name}" on PinGo!\n'
          '${map.description ?? ''}';

      await repository.shareUrl(url: link, message: text);
    });
  }

  String _formatDuration(int seconds) {
    final Duration d = Duration(seconds: seconds);
    final int hours = d.inHours;
    final int minutes = d.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
}
