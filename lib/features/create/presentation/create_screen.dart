import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.allXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.neutral.s900,
                    ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Capture your journey, pin a memory, or plan a trip.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.neutral.s700,
                    ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Expanded(
                child: ListView(
                  children: [
                    _CreateOptionCard(
                      icon: Icons.directions_walk,
                      title: 'Start Journey',
                      subtitle: 'Record a route or map manually',
                      color: AppColors.primary.s500,
                      onTap: () => context.go(
                          '${RoutePaths.create}/${RoutePaths.startJourney}'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _CreateOptionCard(
                      icon: Icons.push_pin_outlined,
                      title: 'Add Pin',
                      subtitle: 'Save a location, photo, or note',
                      color: AppColors.primary.s300,
                      onTap: () => context
                          .go('${RoutePaths.create}/${RoutePaths.addPin}'),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _CreateOptionCard(
                      icon: Icons.calendar_month_outlined,
                      title: 'Create Troupe',
                      subtitle: 'Plan a trip and itinerary',
                      color: AppColors.neutral.s900,
                      onTap: () => context.go(
                          '${RoutePaths.create}/${RoutePaths.createTroupe}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _CreateOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.neutral.s100,
      borderRadius: BorderRadius.circular(AppSpacing.lg),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.lg),
        child: Padding(
          padding: AppSpacing.allLg,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.neutral.s700,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.neutral.s500),
            ],
          ),
        ),
      ),
    );
  }
}
