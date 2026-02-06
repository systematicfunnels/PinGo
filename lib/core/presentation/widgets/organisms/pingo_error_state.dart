import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';

enum PingoErrorStateVariant {
  network,
  permission,
  generic,
}

class PingoErrorState extends StatelessWidget {
  final PingoErrorStateVariant variant;
  final String title;
  final String? subtitle;
  final VoidCallback? onRetry;
  final String? retryLabel;

  const PingoErrorState({
    super.key,
    this.variant = PingoErrorStateVariant.generic,
    required this.title,
    this.subtitle,
    this.onRetry,
    this.retryLabel,
  });

  const PingoErrorState.network({
    super.key,
    this.title = "No Connection",
    this.subtitle = "Please check your internet settings.",
    this.onRetry,
    this.retryLabel = "Try Again",
  }) : variant = PingoErrorStateVariant.network;

  const PingoErrorState.permission({
    super.key,
    this.title = "Permission Required",
    this.subtitle = "We need access to continue.",
    this.onRetry,
    this.retryLabel = "Open Settings",
  }) : variant = PingoErrorStateVariant.permission;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    switch (variant) {
      case PingoErrorStateVariant.network:
        icon = Icons.wifi_off;
        break;
      case PingoErrorStateVariant.permission:
        icon = Icons.security;
        break;
      case PingoErrorStateVariant.generic:
        icon = Icons.error_outline;
        break;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PingoIcon(
              icon,
              size: PingoIconSize.xlarge,
              color: AppColors.error.s300,
            ),
            const SizedBox(height: AppSpacing.lg),
            PingoText.heading(
              title,
              textAlign: TextAlign.center,
              size: PingoTextSize.medium,
              color: AppColors.neutral.s900,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppSpacing.sm),
              PingoText.body(
                subtitle!,
                textAlign: TextAlign.center,
                color: AppColors.neutral.s600,
              ),
            ],
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              PingoButton.secondary(
                label: retryLabel ?? "Retry",
                onPressed: onRetry,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
