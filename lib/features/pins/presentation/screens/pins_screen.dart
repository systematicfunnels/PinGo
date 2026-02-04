import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/features/route_recording/presentation/widgets/journey_list.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import '../controllers/pins_controller.dart';
import '../widgets/pin_editor_sheet.dart';

class PinsScreen extends ConsumerStatefulWidget {
  const PinsScreen({super.key});

  @override
  ConsumerState<PinsScreen> createState() => _PinsScreenState();
}

class _PinsScreenState extends ConsumerState<PinsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Journey',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'pinsFab',
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
                    label: Text('Pins'),
                    icon: Icon(Icons.place_outlined),
                  ),
                  ButtonSegment(
                    value: 1,
                    label: Text('Journeys'),
                    icon: Icon(Icons.timeline),
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
                        return AppColors.primary.withValues(alpha: 0.1);
                      }
                      return Colors.transparent;
                    },
                  ),
                  foregroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return AppColors.primary;
                      }
                      return AppColors.textSecondary;
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                _selectedIndex == 0 ? const _PinsList() : const JourneyList(),
          ),
        ],
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
                const SizedBox(height: AppSpacing.lg),
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
          padding: AppSpacing.allLg,
          itemCount: pins.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final pin = pins[index];
            return Dismissible(
              key: ValueKey(pin.id),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: AppSpacing.lg),
                color: AppColors.danger,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Delete"),
                      content: const Text("Are you sure you want to delete this pin?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text("Delete", style: TextStyle(color: AppColors.danger)),
                        ),
                      ],
                    );
                  },
                );
              },
              onDismissed: (_) {
                ref.read(pinsControllerProvider.notifier).deletePin(pin.id);
              },
              child: Card(
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
                        size: AppSpacing.lg,
                        color: AppColors.textTertiary,
                      ),
                    ],
                  ),
                  subtitle: Text(
                    pin.description ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
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
