import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';

enum PingoBadgeVariant {
  role,
  status,
}

enum PingoBadgeState {
  active,
  inactive,
}

class PingoBadge extends StatelessWidget {
  final String label;
  final PingoBadgeVariant variant;
  final PingoBadgeState state;
  final IconData? icon;

  const PingoBadge({
    super.key,
    required this.label,
    this.variant = PingoBadgeVariant.status,
    this.state = PingoBadgeState.active,
    this.icon,
  });

  const PingoBadge.role(
    this.label, {
    super.key,
    this.state = PingoBadgeState.active,
    this.icon,
  }) : variant = PingoBadgeVariant.role;

  const PingoBadge.status(
    this.label, {
    super.key,
    this.state = PingoBadgeState.active,
    this.icon,
  }) : variant = PingoBadgeVariant.status;

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final bgColor = colors.$1;
    final fgColor = colors.$2;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2, // Extra small vertical padding for badges
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.all4,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            PingoIcon(
              icon!,
              size: PingoIconSize.small,
              color: fgColor,
            ),
            const SizedBox(width: 4),
          ],
          PingoText.caption(
            label,
            color: fgColor,
          ),
        ],
      ),
    );
  }

  (Color, Color) _getColors() {
    switch (variant) {
      case PingoBadgeVariant.role:
        if (state == PingoBadgeState.active) {
          return (AppColors.primary.s100, AppColors.primary.s500);
        }
        return (AppColors.neutral.s300, AppColors.neutral.s700);

      case PingoBadgeVariant.status:
        if (state == PingoBadgeState.active) {
          return (
            AppColors.success.s500.withValues(alpha: 0.2),
            AppColors.success.s500
          );
        }
        return (AppColors.neutral.s300, AppColors.neutral.s700);
    }
  }
}
