import 'package:flutter/material.dart';
import 'package:pingo/core/theme/app_theme.dart';
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
        borderRadius: BorderRadius.circular(30), // Pill shape
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
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
