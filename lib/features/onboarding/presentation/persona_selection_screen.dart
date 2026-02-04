import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/routing/route_paths.dart';

class PersonaSelectionScreen extends StatelessWidget {
  const PersonaSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
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
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Persona Cards
              _PersonaCard(
                icon: Icons.backpack_outlined,
                label: 'Traveler',
                description: 'Finding new paths in new places.',
                onTap: () => context.go(RoutePaths.map),
              ),
              const SizedBox(height: AppSpacing.lg),
              _PersonaCard(
                icon: Icons.landscape_outlined,
                label: 'Explorer',
                description: 'Going where maps are empty.',
                onTap: () => context.go(RoutePaths.map),
              ),
              const SizedBox(height: AppSpacing.lg),
              _PersonaCard(
                icon: Icons.camera_alt_outlined,
                label: 'Observer',
                description: 'Capturing moments quietly.',
                onTap: () => context.go(RoutePaths.map),
              ),

              const Spacer(),

              // Skip
              TextButton(
                onPressed: () => context.go(RoutePaths.map),
                child: Text(
                  'Skip for now',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.lg),
      child: Container(
        padding: AppSpacing.allXl,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.lg),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: AppSpacing.allMd,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: AppSpacing.lg, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
