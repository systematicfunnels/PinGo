import 'package:flutter/material.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/presentation/widgets/molecules/molecules.dart';
import 'package:pingo/features/explore/presentation/widgets/discover_sheet.dart';
import 'package:pingo/features/explore/presentation/widgets/explore_map_view.dart';
import 'package:pingo/features/explore/presentation/widgets/explore_search_bar.dart';
import 'package:pingo/features/pins/presentation/widgets/pin_editor_sheet.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Map View (Base Layer)
          const Positioned.fill(
            child: ExploreMapView(),
          ),

          // 2. Search Bar (Top Layer)
          const SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ExploreSearchBar(),
            ),
          ),

          // 3. Discover Sheet (Bottom Layer)
          const DiscoverSheet(),

          // 4. Pin Moment FAB
          Positioned(
            right: AppSpacing.lg,
            bottom: AppSpacing.xxl + 80, // Explicit offset for bottom nav
            child: PingoFab(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const PinEditorSheet(
                    captureImmediately: true,
                  ),
                );
              },
              icon: Icons.add_a_photo,
              label: 'Pin Moment',
              isExtended: true,
            ),
          ),
        ],
      ),
    );
  }
}
