import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';

enum PingoProgressType {
  line,
  circular,
}

class PingoProgressIndicator extends StatelessWidget {
  final PingoProgressType type;
  final double? value; // null for indeterminate
  final bool isActive;
  final Color? color;
  final Color? backgroundColor;

  const PingoProgressIndicator({
    super.key,
    this.type = PingoProgressType.circular,
    this.value,
    this.isActive = true,
    this.color,
    this.backgroundColor,
  });

  const PingoProgressIndicator.line({
    super.key,
    this.value,
    this.isActive = true,
    this.color,
    this.backgroundColor,
  }) : type = PingoProgressType.line;

  const PingoProgressIndicator.circular({
    super.key,
    this.value,
    this.isActive = true,
    this.color,
    this.backgroundColor,
  }) : type = PingoProgressType.circular;

  @override
  Widget build(BuildContext context) {
    if (!isActive) {
      return const SizedBox.shrink();
    }

    final effectiveColor = color ?? AppColors.primary.s500;
    final effectiveBackgroundColor = backgroundColor ?? AppColors.neutral.s300.withValues(alpha: 0.3);

    switch (type) {
      case PingoProgressType.line:
        return LinearProgressIndicator(
          value: value,
          color: effectiveColor,
          backgroundColor: effectiveBackgroundColor,
        );
      case PingoProgressType.circular:
        return CircularProgressIndicator(
          value: value,
          color: effectiveColor,
          backgroundColor: effectiveBackgroundColor,
        );
    }
  }
}
