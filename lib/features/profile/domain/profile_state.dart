import 'models/user.dart';

class ProfileStats {
  final int totalPins;
  final int totalJourneys;
  final double totalDistanceMeters;
  final int totalDurationHours;

  const ProfileStats({
    this.totalPins = 0,
    this.totalJourneys = 0,
    this.totalDistanceMeters = 0,
    this.totalDurationHours = 0,
  });
}

class ProfileState {
  final bool isLoading;
  final User? user;
  final ProfileStats stats;
  final String? error;

  const ProfileState({
    this.isLoading = false,
    this.user,
    this.stats = const ProfileStats(),
    this.error,
  });

  ProfileState copyWith({
    bool? isLoading,
    User? user,
    ProfileStats? stats,
    String? error,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      stats: stats ?? this.stats,
      error: error,
    );
  }
}
