import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';

enum PingoPinPreviewCardVariant {
  compact,
  full,
}

class PingoPinPreviewCard extends StatelessWidget {
  final PingoPinPreviewCardVariant variant;
  final bool isExpanded;
  final String title;
  final String? subtitle;
  final String? description;
  final VoidCallback? onTap;
  final VoidCallback? onAction;

  const PingoPinPreviewCard({
    super.key,
    this.variant = PingoPinPreviewCardVariant.compact,
    this.isExpanded = false,
    required this.title,
    this.subtitle,
    this.description,
    this.onTap,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.neutral.s100,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle for bottom sheet feel
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.neutral.s300,
                  borderRadius: AppRadius.allFull,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Title & Subtitle
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PingoText.heading(
                        title,
                        size: PingoTextSize.medium,
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSpacing.xs),
                        PingoText.body(
                          subtitle!,
                          color: AppColors.neutral.s500,
                          size: PingoTextSize.small,
                        ),
                      ],
                    ],
                  ),
                ),
                if (variant == PingoPinPreviewCardVariant.compact)
                  PingoButton.secondary(
                    label: "View",
                    onPressed: onAction,
                    isFullWidth: false,
                  ),
              ],
            ),

            // Expanded Content
            if (isExpanded || variant == PingoPinPreviewCardVariant.full) ...[
              const SizedBox(height: AppSpacing.md),
              if (description != null)
                PingoText.body(
                  description!,
                  color: AppColors.neutral.s700,
                ),
              const SizedBox(height: AppSpacing.lg),
              PingoButton.primary(
                label: "Navigate",
                onPressed: onAction,
                isFullWidth: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
