import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/route_recording/data/repositories/journey_repository_impl.dart';
import '../../domain/profile_state.dart';
import '../../data/repositories/user_repository_impl.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<ProfileState> build() async {
    state = const AsyncValue.loading();

    try {
      // 1. Get User data
      final userRepo = ref.watch(userRepositoryProvider);
      final user = await userRepo.getCurrentUser();

      // 2. Get Pins count
      final pins = await ref.watch(pinsControllerProvider.future);

      // 3. Get Journeys stats
      final journeyRepo = ref.watch(journeyRepositoryProvider);
      final journeys = await journeyRepo.getAllJourneys();

      double totalDistance = 0;
      int totalSeconds = 0;

      for (final journey in journeys) {
        totalDistance += journey.totalDistance;
        totalSeconds += journey.durationSeconds;
      }

      final stats = ProfileStats(
        totalPins: pins.length,
        totalJourneys: journeys.length,
        totalDistanceMeters: totalDistance,
        totalDurationHours: (totalSeconds / 3600).round(),
      );

      return ProfileState(
        user: user,
        stats: stats,
      );
    } catch (e) {
      return ProfileState(error: e.toString());
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
