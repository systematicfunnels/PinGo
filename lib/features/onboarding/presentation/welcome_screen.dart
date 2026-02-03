import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/routing/route_paths.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
                    'Record a path, drop pins, and capture moments as you go.',
                icon: Icons.route_outlined,
                onTap: () {
                  context.push(RoutePaths.library);
                },
              ),

              const SizedBox(height: 16),

              // Explore Quietly Card
              _buildChoiceCard(
                context,
                title: 'Explore quietly',
                description: 'Just open the map. No recording, no pressure.',
                icon: Icons.map_outlined,
                isSecondary: true,
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
      color: isSecondary ? AppColors.surface : AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isSecondary
            ? const BorderSide(color: AppColors.border)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSecondary ? AppColors.primary : AppColors.onPrimary,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isSecondary
                                ? AppColors.textPrimary
                                : AppColors.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isSecondary
                                ? AppColors.textSecondary
                                : AppColors.onPrimary.withValues(alpha: 0.8),
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: isSecondary
                    ? AppColors.textTertiary
                    : AppColors.onPrimary.withValues(alpha: 0.5),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
