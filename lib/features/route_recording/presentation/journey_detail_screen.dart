import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/route_recording/data/repositories/journey_repository_impl.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/presentation/widgets/visibility_selector.dart';
import 'package:pingo/features/route_recording/domain/models/journey.dart';
import 'package:pingo/core/routing/route_paths.dart';

class JourneyDetailScreen extends ConsumerWidget {
  final String journeyId;

  const JourneyDetailScreen({
    super.key,
    required this.journeyId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ideally we'd have a specific provider for single journey,
    // but for MVP we can filter from the list or add a getJourney(id) method.
    // Let's assume we use the repository directly for a single fetch or stream.

    final journeyAsync = ref.watch(singleJourneyProvider(journeyId));

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(
          RoutePaths.memoryReplay.replaceFirst(':id', journeyId),
        ),
        icon: const Icon(Icons.play_circle_outline),
        label: const Text('Replay Journey'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: journeyAsync.when(
        data: (journey) {
          if (journey == null) {
            return const Center(child: Text('Journey not found'));
          }

          final points =
              journey.routePoints.map((p) => LatLng(p[0], p[1])).toList();

          // Calculate bounds for the map
          final bounds = LatLngBounds.fromPoints(
              points.isNotEmpty ? points : [const LatLng(0, 0)]);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: AppColors.background,
                actions: const [],
                leading: Container(
                  margin: AppSpacing.allSm,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.textPrimary),
                    onPressed: () => context.pop(),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: points.isNotEmpty
                      ? FlutterMap(
                          options: MapOptions(
                            initialCameraFit: CameraFit.bounds(
                              bounds: bounds,
                              padding: AppSpacing.allXxl,
                            ),
                            interactionOptions: const InteractionOptions(
                              flags:
                                  InteractiveFlag.all & ~InteractiveFlag.rotate,
                            ),
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.pingo',
                            ),
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: points,
                                  color: AppColors.primary,
                                  strokeWidth: 4.0,
                                ),
                              ],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: points.first,
                                  width: AppSpacing.xl,
                                  height: AppSpacing.xl,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                                Marker(
                                  point: points.last,
                                  width: AppSpacing.xl,
                                  height: AppSpacing.xl,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : const Center(child: Text('No route data')),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.allXl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  journey.name ?? 'Untitled Journey',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  DateFormat.yMMMd()
                                      .add_jm()
                                      .format(journey.startTime),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          // Share Button (Screen 13/14 entry point)
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    _ShareSheet(journey: journey),
                              );
                            },
                            icon: const Icon(Icons.share_outlined),
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.surface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Stats Row
                      Container(
                        padding: AppSpacing.allLg,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppSpacing.lg),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatItem(
                              label: 'Distance',
                              value:
                                  '${(journey.totalDistance / 1000).toStringAsFixed(2)} km',
                              icon: Icons.straighten,
                            ),
                            Container(
                                width: 1,
                                height: 40,
                                color: Colors.grey.withValues(alpha: 0.2)),
                            _StatItem(
                              label: 'Duration',
                              value:
                                  '${(journey.durationSeconds / 60).toStringAsFixed(0)} min',
                              icon: Icons.timer_outlined,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                      Text(
                        'Story',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      // Placeholder for pins/notes along the route
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'No pins added to this journey yet.',
                            style: TextStyle(color: AppColors.textTertiary),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      Center(
                        child: TextButton.icon(
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Journey'),
                                content: const Text(
                                    'Are you sure you want to delete this journey? This action cannot be undone.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () => context.pop(true),
                                    child: const Text('Delete',
                                        style:
                                            TextStyle(color: AppColors.danger)),
                                  ),
                                ],
                              ),
                            );

                            if (confirm == true) {
                              await ref
                                  .read(journeyRepositoryProvider)
                                  .deleteJourney(journey.id);
                              if (context.mounted) {
                                context.pop();
                              }
                            }
                          },
                          icon: const Icon(Icons.delete_outline,
                              color: AppColors.danger),
                          label: const Text(
                            'Delete Journey',
                            style: TextStyle(color: AppColors.danger),
                          ),
                        ),
                      ),
                      const SizedBox(height: 80), // Space for FAB
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _ShareSheet extends ConsumerStatefulWidget {
  final Journey journey;

  const _ShareSheet({required this.journey});

  @override
  ConsumerState<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends ConsumerState<_ShareSheet> {
  late ContentVisibility _visibility;

  @override
  void initState() {
    super.initState();
    _visibility = widget.journey.visibility;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 32,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Share Journey',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 24),
                      VisibilitySelector(
                        selected: _visibility,
                        onChanged: (v) async {
                          setState(() => _visibility = v);
                          // Update journey visibility
                          final updatedJourney = Journey(
                            id: widget.journey.id,
                            name: widget.journey.name,
                            startTime: widget.journey.startTime,
                            endTime: widget.journey.endTime,
                            routePoints: widget.journey.routePoints,
                            totalDistance: widget.journey.totalDistance,
                            durationSeconds: widget.journey.durationSeconds,
                            visibility: v,
                          );
                          await ref
                              .read(journeyRepositoryProvider)
                              .updateJourney(updatedJourney);
                        },
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () {
                          // TODO: Implement actual share (generate link/image)
                          context.pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Link copied to clipboard! விண்ணப்பி')),
                          );
                        },
                        icon: const Icon(Icons.copy),
                        label: const Text('Copy Link'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            )));
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
              ),
        ),
      ],
    );
  }
}

// Simple provider to fetch a single journey by ID
final singleJourneyProvider =
    FutureProvider.family.autoDispose((ref, String id) async {
  final repo = ref.watch(journeyRepositoryProvider);
  final all = await repo.getAllJourneys();
  try {
    return all.firstWhere((j) => j.id == int.parse(id));
  } catch (_) {
    return null;
  }
});
