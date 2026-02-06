import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/molecules/pingo_button.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/spacing.dart';

class StickyActionBottomBar extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const StickyActionBottomBar({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.neutral.s100,
        boxShadow: AppElevation.floating,
      ),
      child: PingoButton.primary(
        onPressed: onPressed,
        isLoading: isLoading,
        label: label,
      ),
    );
  }
}
