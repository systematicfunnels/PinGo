import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pingo/core/theme/app_theme.dart';
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
                      width: 20,
                      height: 20,
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
            left: 16,
            right: 16,
            bottom: 32,
            child: Card(
              elevation: 4,
              shadowColor: Colors.black12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!recordState.isRecording) ...[
                      // Start State
                      const Text(
                        'Ready to explore?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(recordControllerProvider.notifier)
                                .startRecording();
                          },
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Start Journey'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                          ),
                        ),
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
                              const SizedBox(height: 4),
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
                              const SizedBox(height: 4),
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
                      const SizedBox(height: 24),
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
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                side: const BorderSide(color: AppColors.border),
                                foregroundColor: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                ref
                                    .read(recordControllerProvider.notifier)
                                    .stopRecording();
                              },
                              icon: const Icon(Icons.stop_rounded),
                              label: const Text('Finish'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.danger,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                elevation: 0,
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
