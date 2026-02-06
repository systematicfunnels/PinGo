import 'package:flutter/material.dart';
import 'package:pingo/core/theme/radius.dart';

enum PingoColorBlockType {
  semantic,
  neutral,
}

class PingoColorBlock extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final PingoColorBlockType type;

  const PingoColorBlock({
    super.key,
    required this.color,
    this.width = 24.0,
    this.height = 24.0,
    this.borderRadius,
    this.type = PingoColorBlockType.neutral,
  });

  const PingoColorBlock.semantic(
    this.color, {
    super.key,
    this.width = 24.0,
    this.height = 24.0,
    this.borderRadius,
  }) : type = PingoColorBlockType.semantic;

  const PingoColorBlock.neutral(
    this.color, {
    super.key,
    this.width = 24.0,
    this.height = 24.0,
    this.borderRadius,
  }) : type = PingoColorBlockType.neutral;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? AppRadius.all4,
      ),
    );
  }
}
