import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/features/route_recording/presentation/widgets/journey_list.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import '../controllers/pins_controller.dart';
import '../widgets/pin_editor_sheet.dart';

class PinsScreen extends ConsumerWidget {
  const PinsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Journey',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          backgroundColor: AppColors.background,
          elevation: 0,
          bottom: const TabBar(
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textTertiary,
            indicatorColor: AppColors.primary,
            tabs: [
              Tab(text: 'Pins'),
              Tab(text: 'Journeys'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const PinEditorSheet(),
            );
          },
          label: const Text('Drop Pin'),
          icon: const Icon(Icons.add_location_alt_outlined),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
        ),
        body: const TabBarView(
          children: [
            // Tab 1: Pins List
            _PinsList(),

            // Tab 2: Journeys List
            JourneyList(),
          ],
        ),
      ),
    );
  }
}

class _PinsList extends ConsumerWidget {
  const _PinsList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinsAsync = ref.watch(pinsControllerProvider);

    return pinsAsync.when(
      data: (pins) {
        if (pins.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.map_outlined,
                  size: 64,
                  color: AppColors.textTertiary.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'No pins yet.\nStart your journey to add some memories.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: pins.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final pin = pins[index];
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppColors.secondary.withValues(alpha: 0.2),
                  child: const Icon(Icons.place, color: AppColors.secondary),
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        pin.title ?? 'Untitled Pin',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Icon(
                      _getVisibilityIcon(pin.visibility),
                      size: 14,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
                subtitle: Text(
                  pin.description ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline,
                      color: AppColors.textTertiary),
                  onPressed: () {
                    ref.read(pinsControllerProvider.notifier).deletePin(pin.id);
                  },
                ),
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  IconData _getVisibilityIcon(ContentVisibility visibility) {
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
