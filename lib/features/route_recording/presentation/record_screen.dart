import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/map/presentation/map_controller.dart';
import 'controllers/record_controller.dart';

class RecordScreen extends ConsumerWidget {
  const RecordScreen({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = duration.inHours > 0 ? '${duration.inHours}:' : '';
    return '$hours$minutes:$seconds';
  }

  String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.toStringAsFixed(0)} m';
    }
    return '${(meters / 1000).toStringAsFixed(2)} km';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordState = ref.watch(recordControllerProvider);
    final locationAsync = ref.watch(mapControllerProvider);

    // Initial center (London) or current location
    final initialCenter = locationAsync.value != null
        ? LatLng(locationAsync.value!.latitude, locationAsync.value!.longitude)
        : const LatLng(51.509364, -0.128928);

    return Scaffold(
      body: Stack(
        children: [
          // Map Background
          FlutterMap(
            options: MapOptions(
              initialCenter: initialCenter,
              initialZoom: 16.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.pingo',
              ),
              // Recorded Path
              if (recordState.currentPath.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: recordState.currentPath,
                      color: AppColors.primary,
                      strokeWidth: 4.0,
                    ),
                  ],
                ),
              // Current Location Marker (if we have one from MapController or Recorder)
              if (locationAsync.value != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: recordState.currentPath.isNotEmpty
                          ? recordState.currentPath.last
                          : LatLng(locationAsync.value!.latitude,
                              locationAsync.value!.longitude),
                      width: AppSpacing.xl,
                      height: AppSpacing.xl,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),

          // Controls Overlay
          Positioned(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.xxl + MediaQuery.of(context).padding.bottom,
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.xl),
              ),
              child: Padding(
                padding: AppSpacing.allXl,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!recordState.isRecording) ...[
                      // Start State - Screen 6: Start Journey
                      const Text(
                        'Where are you heading?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(recordControllerProvider.notifier)
                                .startRecording();
                          },
                          icon: const Icon(Icons.circle, size: 12),
                          label: const Text('Record route'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            elevation: 0,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Switch to Map Tab (index 0) to "Create map manually"
                            // Using GoRouter to navigate to the map branch
                            context.go(RoutePaths.map);
                          },
                          icon: const Icon(Icons.map_outlined, size: 20),
                          label: const Text('Create map manually'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.textPrimary,
                            side: const BorderSide(color: AppColors.border),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.offline_pin_outlined,
                            size: 16,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Offline ready',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textTertiary),
                          ),
                        ],
                      ),
                    ] else ...[
                      // Recording State
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'DURATION',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: AppColors.textTertiary),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                _formatDuration(recordState.duration),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: AppColors.border,
                          ),
                          Column(
                            children: [
                              Text(
                                'DISTANCE',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: AppColors.textTertiary),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                _formatDistance(recordState.distance),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                if (recordState.isPaused) {
                                  ref
                                      .read(recordControllerProvider.notifier)
                                      .resumeRecording();
                                } else {
                                  ref
                                      .read(recordControllerProvider.notifier)
                                      .pauseRecording();
                                }
                              },
                              icon: Icon(recordState.isPaused
                                  ? Icons.play_arrow
                                  : Icons.pause),
                              label: Text(
                                  recordState.isPaused ? 'Resume' : 'Pause'),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppSpacing.lg),
                                side: const BorderSide(color: AppColors.border),
                                foregroundColor: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(
                            child: GestureDetector(
                              onLongPress: () async {
                                final journeyId = await ref
                                    .read(recordControllerProvider.notifier)
                                    .stopRecording();
                                if (context.mounted && journeyId != null) {
                                  context.push(RoutePaths.journeySummary
                                      .replaceFirst(
                                          ':id', journeyId.toString()));
                                }
                              },
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Hold to finish journey'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.stop_rounded),
                                label: const Text('Hold to Finish'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.danger,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: AppSpacing.lg),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
