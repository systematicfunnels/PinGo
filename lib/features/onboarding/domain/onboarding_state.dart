enum Persona {
  traveler,
  explorer,
  observer,
}

class OnboardingState {
  final bool isLoading;
  final Persona? selectedPersona;
  final bool isOnboardingCompleted;

  const OnboardingState({
    this.isLoading = false,
    this.selectedPersona,
    this.isOnboardingCompleted = false,
  });

  OnboardingState copyWith({
    bool? isLoading,
    Persona? selectedPersona,
    bool? isOnboardingCompleted,
  }) {
    return OnboardingState(
      isLoading: isLoading ?? this.isLoading,
      selectedPersona: selectedPersona ?? this.selectedPersona,
      isOnboardingCompleted: isOnboardingCompleted ?? this.isOnboardingCompleted,
    );
  }
}
