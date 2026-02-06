import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';

enum PingoEmptyStateVariant {
  explore,
  library,
  generic,
}

class PingoEmptyState extends StatelessWidget {
  final PingoEmptyStateVariant variant;
  final String title;
  final String? subtitle;
  final Widget? action;
  final IconData? icon;

  const PingoEmptyState({
    super.key,
    this.variant = PingoEmptyStateVariant.generic,
    required this.title,
    this.subtitle,
    this.action,
    this.icon,
  });

  const PingoEmptyState.explore({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  })  : variant = PingoEmptyStateVariant.explore,
        icon = Icons.explore_off;

  const PingoEmptyState.library({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  })  : variant = PingoEmptyStateVariant.library,
        icon = Icons.library_books;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PingoIcon(
              icon ?? Icons.inbox,
              size: PingoIconSize.xlarge,
              color: AppColors.neutral.s300,
            ),
            const SizedBox(height: AppSpacing.lg),
            PingoText.heading(
              title,
              textAlign: TextAlign.center,
              size: PingoTextSize.medium,
              color: AppColors.neutral.s700,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.sm),
              PingoText.body(
                subtitle!,
                textAlign: TextAlign.center,
                color: AppColors.neutral.s500,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: AppSpacing.xl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
