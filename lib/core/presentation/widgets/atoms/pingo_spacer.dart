import 'package:flutter/material.dart';
import 'package:pingo/core/theme/spacing.dart';

class PingoSpacer extends StatelessWidget {
  final double size;
  final bool isHorizontal;

  const PingoSpacer(
    this.size, {
    super.key,
    this.isHorizontal = false,
  });

  const PingoSpacer.horizontal(
    this.size, {
    super.key,
  }) : isHorizontal = true;

  const PingoSpacer.vertical(
    this.size, {
    super.key,
  }) : isHorizontal = false;

  // Convenience factories for common sizes
  factory PingoSpacer.s4({bool horizontal = false}) =>
      PingoSpacer(AppSpacing.s4, isHorizontal: horizontal);
  factory PingoSpacer.s8({bool horizontal = false}) =>
      PingoSpacer(AppSpacing.s8, isHorizontal: horizontal);
  factory PingoSpacer.s12({bool horizontal = false}) =>
      PingoSpacer(AppSpacing.s12, isHorizontal: horizontal);
  factory PingoSpacer.s16({bool horizontal = false}) =>
      PingoSpacer(AppSpacing.s16, isHorizontal: horizontal);
  factory PingoSpacer.s24({bool horizontal = false}) =>
      PingoSpacer(AppSpacing.s24, isHorizontal: horizontal);
  factory PingoSpacer.s32({bool horizontal = false}) =>
      PingoSpacer(AppSpacing.s32, isHorizontal: horizontal);
  factory PingoSpacer.s48({bool horizontal = false}) =>
      PingoSpacer(AppSpacing.s48, isHorizontal: horizontal);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isHorizontal ? size : 0,
      height: isHorizontal ? 0 : size,
    );
  }
}
