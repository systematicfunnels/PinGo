import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String role;
  final String bio;
  final int mapCount;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.role,
    required this.bio,
    required this.mapCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary.s500,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 40),
        ),
        const SizedBox(width: AppSpacing.lg),
        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.s500.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      role,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppColors.primary.s500,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    '$mapCount maps',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.neutral.s500,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                bio,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.neutral.s700,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
