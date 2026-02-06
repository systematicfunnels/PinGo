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

              const Spacer(),

              // Skip
              TextButton(
                onPressed: () async {
                  await controller.skipOnboarding();
                  if (context.mounted) context.go(RoutePaths.home);
                },
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
