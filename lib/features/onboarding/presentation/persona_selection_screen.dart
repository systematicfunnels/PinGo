import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/routing/route_paths.dart';

class PersonaSelectionScreen extends StatelessWidget {
  const PersonaSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
              const SizedBox(height: 32),

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
              
              const Spacer(),

              // Skip
              TextButton(
                onPressed: () => context.go(RoutePaths.homeFeed),
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
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.1),
          ),
        ),
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
                  ),
                  const SizedBox(height: 4),
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
                size: 16, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
