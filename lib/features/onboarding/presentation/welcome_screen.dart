import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'onboarding_controller.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.neutral.s50,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.allXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 2),

              Text(
                'Welcome to PinGo',
                style: Theme.of(context).textTheme.displayMedium,
              ),

              const SizedBox(height: AppSpacing.lg),

              Text(
                'How would you like to begin?',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.neutral.s700,
                    ),
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

              Center(
                child: Text(
                  'No account needed to begin.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.neutral.s500,
                        fontStyle: FontStyle.italic,
                      ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
    bool isSecondary = false,
  }) {
    return Card(
      color: isSecondary ? AppColors.neutral.s100 : AppColors.primary.s500,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        side: isSecondary
            ? BorderSide(color: AppColors.neutral.s300)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                                : AppColors.neutral.s100.withValues(alpha: 0.8),
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
      ),
    );
  }
}
