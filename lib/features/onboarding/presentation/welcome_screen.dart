import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'onboarding_controller.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Map Texture
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.network(
                'https://images.unsplash.com/photo-1760783320600-32f1d32f5ded?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHx0b3BvZ3JhcGhpYyUyMG1hcCUyMGFic3RyYWN0fGVufDF8fHx8MTc3MDExMjE1Nnww&ixlib=rb-4.1.0&q=80&w=1080',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: AppColors.surfaceVariant);
                },
              ),
            ),
=======
      backgroundColor: AppColors.neutral.s50,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.allXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),

              const PingoText.display(
                'Welcome to PinGo',
                size: PingoTextSize.medium,
              ),

              const SizedBox(height: AppSpacing.lg),

              PingoText.body(
                'How would you like to begin?',
                color: AppColors.neutral.s700,
                size: PingoTextSize.large,
              ),

              const Spacer(flex: 3),

              // Start a Journey Card
              _buildChoiceCard(
                context,
                title: 'Start a journey',
                description:
                    'Record a path, drop pins, and capture moments as you go.',
                icon: Icons.route_outlined,
                onTap: () async {
                  // Mark onboarding as complete since they are entering the app
                  await ref
                      .read(onboardingControllerProvider.notifier)
                      .completeOnboarding();
                  if (context.mounted) context.go(RoutePaths.create);
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              // Explore Quietly Card
              _buildChoiceCard(
                context,
                title: 'Explore quietly',
                description: 'Just open the map. No recording, no pressure.',
                icon: Icons.map_outlined,
                isSecondary: true,
                onTap: () {
                  // Navigate to Persona selection
                  context.push(RoutePaths.persona);
                },
              ),

              const Spacer(flex: 2),

              const Center(
                child: PingoText.caption(
                  'No account needed to begin.',
                  isMuted: true,
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 2),

                  Text(
                    'Welcome to PinGo',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'How would you like to begin?',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),

                  const Spacer(flex: 3),

                  // Start a Journey Card
                  _buildChoiceCard(
                    context,
                    title: 'Start a journey',
                    description:
                        'Begin mapping your path, capturing moments as you go.',
                    icon: Icons.location_on_outlined,
                    onTap: () {
                      context.push(RoutePaths.homeFeed);
                    },
                  ),

                  const SizedBox(height: 16),

                  // Explore Quietly Card
                  _buildChoiceCard(
                    context,
                    title: 'Explore quietly',
                    description: 'Discover paths and places shared by others.',
                    icon: Icons.visibility_outlined,
                    onTap: () {
                      context.push(RoutePaths.persona);
                    },
                  ),

                  const Spacer(flex: 2),

                  Center(
                    child: Text(
                      'No account needed to begin.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textTertiary,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
<<<<<<< HEAD
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: 'Serif',
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                  ),
                ],
              ),
            ),
          ],
=======
    return Container(
      decoration: BoxDecoration(
        color: isSecondary ? AppColors.neutral.s100 : AppColors.primary.s500,
        borderRadius: AppRadius.all12,
        boxShadow: AppElevation.card,
        border: isSecondary
            ? Border.all(color: AppColors.neutral.s300)
            : Border.all(style: BorderStyle.none),
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
                Icon(
                  icon,
                  color: isSecondary
                      ? AppColors.primary.s500
                      : AppColors.neutral.s100,
                  size: AppSpacing.xxl,
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: isSecondary
                                      ? AppColors.neutral.s900
                                      : AppColors.neutral.s100,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isSecondary
                                  ? AppColors.neutral.s700
                                  : AppColors.neutral.s100
                                      .withValues(alpha: 0.8),
                            ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isSecondary
                      ? AppColors.neutral.s500
                      : AppColors.neutral.s100.withValues(alpha: 0.5),
                  size: AppSpacing.lg,
                ),
              ],
            ),
          ),
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
        ),
      ),
    );
  }
}
