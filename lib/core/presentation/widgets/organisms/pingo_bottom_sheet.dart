import 'package:flutter/material.dart';
import 'package:pingo/core/presentation/widgets/atoms/atoms.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';

enum PingoBottomSheetVariant {
  peek,
  full,
}

class PingoBottomSheet extends StatelessWidget {
  final PingoBottomSheetVariant variant;
  final String? title;
  final Widget child;
  final Widget? footer;

  const PingoBottomSheet({
    super.key,
    this.variant = PingoBottomSheetVariant.peek,
    this.title,
    required this.child,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.neutral.s300,
                borderRadius: AppRadius.allFull,
              ),
            ),
          ),

          // Title
          if (title != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.xs,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: PingoText.heading(
                title!,
                size: PingoTextSize.medium,
                textAlign: TextAlign.center,
              ),
            ),

          // Content
          Flexible(
            fit: variant == PingoBottomSheetVariant.full ? FlexFit.loose : FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: child,
            ),
          ),

          // Footer (e.g., Actions)
          if (footer != null)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: footer!,
            ),
            
          // Safe Area for bottom
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
