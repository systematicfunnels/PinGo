import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/library/presentation/widgets/library_maps_list.dart';
import 'package:pingo/features/library/presentation/widgets/library_pins_list.dart';
import 'package:pingo/features/library/presentation/widgets/user_maps_list.dart';
import 'package:pingo/features/route_recording/presentation/widgets/journey_list.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Library',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: AppColors.neutral.s50,
        elevation: 0,
      ),
      floatingActionButton: _buildFab(),
      body: Column(
        children: [
          Padding(
            padding: AppSpacing.allLg,
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<int>(
                segments: const [
                  ButtonSegment(
                    value: 0,
                    label: Text('Maps'),
                    icon: Icon(Icons.map_outlined),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Pins'),
                    icon: Icon(Icons.place_outlined),
                  ),
                  ButtonSegment(
                    value: 2,
                    label: Text('Routes'),
                    icon: Icon(Icons.timeline),
                  ),
                  ButtonSegment(
                    value: 3,
                    label: Text('Offline'),
                    icon: Icon(Icons.download_done),
                  ),
                ],
                selected: {_selectedIndex},
                onSelectionChanged: (Set<int> newSelection) {
                  setState(() {
                    _selectedIndex = newSelection.first;
                  });
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary.s500.withOpacity(0.1);
                      }
                      return Colors.transparent;
                    },
                  ),
                  foregroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary.s500;
                      }
                      return AppColors.textSecondary;
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildSelectedView(),
          ),
        ],
      ),
    );
  }

  Widget? _buildFab() {
    if (_selectedIndex == 3) {
      return FloatingActionButton.extended(
        onPressed: () {
          context.go(RoutePaths.regionSelection);
        },
        backgroundColor: AppColors.primary.s500,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.download),
        label: const Text('Download Region'),
      );
    }
    return null;
  }

  Widget _buildSelectedView() {
    switch (_selectedIndex) {
      case 0:
        return const UserMapsList();
      case 1:
        return const LibraryPinsList();
      case 2:
        return const JourneyList();
      case 3:
        return const LibraryMapsList();
      default:
        return const SizedBox.shrink();
    }
  }
}
