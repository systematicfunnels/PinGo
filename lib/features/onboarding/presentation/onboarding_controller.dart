import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/onboarding_state.dart';

// Simple mock for local storage until SharedPreferences is added
class OnboardingLocalSource {
  Future<void> savePersona(Persona persona) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate IO
  }

  Future<void> completeOnboarding() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate IO
  }

  Future<bool> checkOnboardingStatus() async {
    await Future.delayed(
        const Duration(milliseconds: 800)); // Simulate startup check
    return false; // Always return false for now to show onboarding
  }
}

final onboardingLocalSourceProvider =
    Provider((ref) => OnboardingLocalSource());

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, OnboardingState>(
        OnboardingController.new);

class OnboardingController extends Notifier<OnboardingState> {
  @override
  OnboardingState build() {
    return const OnboardingState();
  }

  Future<void> selectPersona(Persona persona) async {
    state = state.copyWith(isLoading: true);
    try {
      await ref.read(onboardingLocalSourceProvider).savePersona(persona);
      // Also complete onboarding when persona is selected
      await ref.read(onboardingLocalSourceProvider).completeOnboarding();

      state = state.copyWith(
        isLoading: false,
        selectedPersona: persona,
        isOnboardingCompleted: true,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> completeOnboarding() async {
    state = state.copyWith(isLoading: true);
    try {
      await ref.read(onboardingLocalSourceProvider).completeOnboarding();
      state = state.copyWith(
        isLoading: false,
        isOnboardingCompleted: true,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> skipOnboarding() async {
    await completeOnboarding();
  }
}
