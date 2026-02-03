import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/route_recording/data/repositories/journey_repository_impl.dart';

part 'profile_controller.g.dart';

class ProfileStats {
  final int totalPins;
  final int totalJourneys;
  final double totalDistanceKm;
  final int totalDurationHours;

  const ProfileStats({
    this.totalPins = 0,
    this.totalJourneys = 0,
    this.totalDistanceKm = 0,
    this.totalDurationHours = 0,
  });
}

@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<ProfileStats> build() async {
    // 1. Get Pins count
    final pins = await ref.watch(pinsControllerProvider.future);

    // 2. Get Journeys stats
    final journeyRepo = ref.watch(journeyRepositoryProvider);
    final journeys = await journeyRepo.getAllJourneys();

    double totalDistance = 0;
    int totalSeconds = 0;

    for (final journey in journeys) {
      totalDistance += journey.totalDistance;
      totalSeconds += journey.durationSeconds;
    }

    return ProfileStats(
      totalPins: pins.length,
      totalJourneys: journeys.length,
      totalDistanceKm: totalDistance / 1000,
      totalDurationHours: (totalSeconds / 3600).round(),
    );
  }
}
