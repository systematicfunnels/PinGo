import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';

enum PingoRouteRecorderVariant {
  live,
  paused,
}

class PingoRouteRecorder extends StatelessWidget {
  final PingoRouteRecorderVariant variant;
  final String duration;
  final String distance;
  final VoidCallback? onPause;
  final VoidCallback? onResume;
  final VoidCallback? onStop;

  const PingoRouteRecorder({
    super.key,
    required this.variant,
    required this.duration,
    required this.distance,
    this.onPause,
    this.onResume,
    this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    final isRecording = variant == PingoRouteRecorderVariant.live;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.neutral.s100,
        borderRadius: AppRadius.all16,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Recording Indicator
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isRecording ? AppColors.error.s500 : AppColors.neutral.s400,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.md),

          // Stats
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PingoText.heading(
                  duration,
                  size: PingoTextSize.medium,
                ),
                PingoText.caption(
                  distance,
                  color: AppColors.neutral.s500,
                ),
              ],
            ),
          ),

          // Controls
          if (isRecording)
            PingoIconButton(
              icon: Icons.pause,
              onPressed: onPause,
              backgroundColor: AppColors.neutral.s200,
              tooltip: "Pause Recording",
            )
          else ...[
            PingoIconButton(
              icon: Icons.play_arrow,
              onPressed: onResume,
              backgroundColor: AppColors.primary.s100,
              color: AppColors.primary.s700,
              tooltip: "Resume Recording",
            ),
            const SizedBox(width: AppSpacing.sm),
            PingoIconButton(
              icon: Icons.stop,
              onPressed: onStop,
              backgroundColor: AppColors.error.s100,
              color: AppColors.error.s700,
              tooltip: "Stop Recording",
            ),
          ],
        ],
      ),
    );
  }
}
