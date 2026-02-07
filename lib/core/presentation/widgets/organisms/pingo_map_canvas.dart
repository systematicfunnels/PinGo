import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/theme/app_theme.dart';

enum PingoMapCanvasVariant {
  explore,
  create,
}

class PingoMapCanvas extends StatelessWidget {
  final PingoMapCanvasVariant variant;
  final bool isLoading;
  final bool isOffline;
  final Widget? mapContent;
  final Widget? overlayContent;

  const PingoMapCanvas({
    super.key,
    this.variant = PingoMapCanvasVariant.explore,
    this.isLoading = false,
    this.isOffline = false,
    this.mapContent,
    this.overlayContent,
  });

  const PingoMapCanvas.explore({
    super.key,
    this.isLoading = false,
    this.isOffline = false,
    this.mapContent,
    this.overlayContent,
  }) : variant = PingoMapCanvasVariant.explore;

  const PingoMapCanvas.create({
    super.key,
    this.isLoading = false,
    this.isOffline = false,
    this.mapContent,
    this.overlayContent,
  }) : variant = PingoMapCanvasVariant.create;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Map Layer
        Container(
          color: AppColors.neutral.s200, // Placeholder for map
          child: mapContent ??
              const Center(
                child: PingoText.body("Map Canvas Placeholder"),
              ),
        ),

        // Overlay Layer (Controls, etc.)
        if (overlayContent != null) overlayContent!,

        // Loading State
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: const Center(
              child: PingoProgressIndicator.circular(),
            ),
          ),

        // Offline Indicator
        if (isOffline)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.neutral.s800,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PingoText.caption(
                  "Offline Mode",
                  color: AppColors.neutral.s100,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
