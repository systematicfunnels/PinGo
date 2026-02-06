import 'package:flutter/material.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/presentation/widgets/atoms/pingo_icon.dart';
import 'package:pingo/core/presentation/widgets/atoms/pingo_text.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';

class PingoVisibilitySelector extends StatelessWidget {
  final ContentVisibility selected;
  final ValueChanged<ContentVisibility> onChanged;

  const PingoVisibilitySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PingoText.caption(
          'Visibility',
          color: AppColors.neutral.s700,
        ),
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ContentVisibility.values.map((visibility) {
              final isSelected = selected == visibility;
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: InkWell(
                  onTap: () => onChanged(visibility),
                  borderRadius: AppRadius.allFull,
                  child: Semantics(
                    selected: isSelected,
                    label: visibility.label,
                    button: true,
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 44),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.s500
                            : AppColors.neutral.s100,
                        borderRadius: AppRadius.allFull,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary.s500
                              : Colors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PingoIcon(
                            _getIcon(visibility),
                            size: PingoIconSize.medium,
                            color: isSelected
                                ? AppColors.neutral.s100
                                : AppColors.neutral.s700,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          PingoText.body(
                            visibility.label,
                            color: isSelected
                                ? AppColors.neutral.s100
                                : AppColors.neutral.s900,
                            size: PingoTextSize.small,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  IconData _getIcon(ContentVisibility visibility) {
    switch (visibility) {
      case ContentVisibility.private:
        return Icons.lock_outline;
      case ContentVisibility.trusted:
        return Icons.people_outline;
      case ContentVisibility.public:
        return Icons.public;
    }
  }
}
