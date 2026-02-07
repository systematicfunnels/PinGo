import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/routing/route_paths.dart';
import '../domain/onboarding_state.dart';
import 'onboarding_controller.dart';

class PersonaSelectionScreen extends ConsumerWidget {
  const PersonaSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.neutral.s50,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.allXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                'How do you usually explore?',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: AppColors.neutral.s900,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSpacing.xxl),

<<<<<<< HEAD
              // Persona Cards
              _PersonaCard(
                icon: Icons.flight_outlined,
                label: 'Traveler',
                description: 'I like moving from place to place.',
                onTap: () => context.go(RoutePaths.homeFeed),
              ),
              const SizedBox(height: 16),
              _PersonaCard(
                icon: Icons.explore_outlined,
                label: 'Explorer',
                description: 'I enjoy discovering what\'s not marked.',
                onTap: () => context.go(RoutePaths.homeFeed),
              ),
              const SizedBox(height: 16),
              _PersonaCard(
                icon: Icons.home_outlined,
                label: 'Local',
                description: 'I know this place deeply.',
                onTap: () => context.go(RoutePaths.homeFeed),
              ),
              const SizedBox(height: 16),
              _PersonaCard(
                icon: Icons.landscape_outlined,
                label: 'Mountaineer',
                description: 'I go where paths are uncertain.',
                onTap: () => context.go(RoutePaths.homeFeed),
              ),
              const SizedBox(height: 16),
              _PersonaCard(
                icon: Icons.visibility_outlined,
                label: 'Observer',
                description: 'I like noticing, not rushing.',
                onTap: () => context.go(RoutePaths.homeFeed),
              ),
              
=======
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                // Persona Cards
                _PersonaCard(
                  icon: Icons.backpack_outlined,
                  label: 'Traveler',
                  description: 'Finding new paths in new places.',
                  onTap: () async {
                    await controller.selectPersona(Persona.traveler);
                    if (context.mounted) context.go(RoutePaths.create);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                _PersonaCard(
                  icon: Icons.landscape_outlined,
                  label: 'Explorer',
                  description: 'Going where maps are empty.',
                  onTap: () async {
                    await controller.selectPersona(Persona.explorer);
                    if (context.mounted) context.go(RoutePaths.explore);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                _PersonaCard(
                  icon: Icons.camera_alt_outlined,
                  label: 'Observer',
                  description: 'Capturing moments quietly.',
                  onTap: () async {
                    await controller.selectPersona(Persona.observer);
                    if (context.mounted) context.go(RoutePaths.home);
                  },
                ),
              ],

>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
              const Spacer(),

              // Skip
              TextButton(
<<<<<<< HEAD
                onPressed: () => context.go(RoutePaths.homeFeed),
=======
                onPressed: () async {
                  await controller.skipOnboarding();
                  if (context.mounted) context.go(RoutePaths.home);
                },
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
                child: Text(
                  'Skip for now',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.neutral.s700,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PersonaCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final VoidCallback onTap;

  const _PersonaCard({
    required this.icon,
    required this.label,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral.s100,
        borderRadius: AppRadius.all12,
        boxShadow: AppElevation.card,
        border: Border.all(
          color: AppColors.primary.s500.withValues(alpha: 0.1),
        ),
<<<<<<< HEAD
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontFamily: 'Serif',
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
=======
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.all12,
          child: Padding(
            padding: AppSpacing.allXl,
            child: Row(
              children: [
                Container(
                  padding: AppSpacing.allMd,
                  decoration: BoxDecoration(
                    color: AppColors.primary.s500.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
                  ),
                  child: Icon(icon, color: AppColors.primary.s500),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.neutral.s700,
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: AppSpacing.lg, color: AppColors.neutral.s500),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
