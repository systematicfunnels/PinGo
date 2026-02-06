import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
import 'package:pingo/core/theme/spacing.dart';

import 'package:pingo/features/explore/presentation/widgets/explore_search_view.dart';

class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutral.s100,
        borderRadius: AppRadius.allFull, // Pill shape
        boxShadow: AppElevation.floating,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: AppRadius.allFull,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ExploreSearchView(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.neutral.s700),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    'Search for places, routes...',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.neutral.s500,
                        ),
                  ),
                ),
                Icon(Icons.mic_none, color: AppColors.neutral.s700),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
