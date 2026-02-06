import 'package:flutter/material.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/theme/app_theme.dart';

class VisibilitySelector extends StatelessWidget {
  final ContentVisibility selected;
  final ValueChanged<ContentVisibility> onChanged;

  const VisibilitySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Visibility',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.neutral.s700,
                fontWeight: FontWeight.bold,
              ),
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
                  borderRadius: BorderRadius.circular(AppSpacing.xl),
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
                        borderRadius: BorderRadius.circular(AppSpacing.xl),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary.s500
                              : Colors.grey.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getIcon(visibility),
                            size: AppSpacing.lg,
                            color: isSelected
                                ? AppColors.neutral.s100
                                : AppColors.neutral.s700,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            visibility.label,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.neutral.s100
                                  : AppColors.neutral.s900,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
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
