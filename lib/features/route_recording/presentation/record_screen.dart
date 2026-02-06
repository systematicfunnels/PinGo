import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:pingo/core/presentation/widgets/pingo_button.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/presentation/utils/snackbar_utils.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/map/presentation/map_controller.dart';
import 'controllers/record_controller.dart';

class RecordScreen extends ConsumerStatefulWidget {
  const RecordScreen({super.key});

  @override
  ConsumerState<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends ConsumerState<RecordScreen> {
  bool _isStarting = false;
  bool _isStopping = false;

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

  Future<void> _handleStartRecording() async {
    setState(() => _isStarting = true);
    try {
      final permission =
          await ref.read(recordControllerProvider.notifier).startRecording();

      if (mounted &&
          (permission == LocationPermission.denied ||
              permission == LocationPermission.deniedForever)) {
        SnackbarUtils.show(
          "We need location to map your journey.",
          isError: true,
          actionLabel: 'Settings',
          onAction: Geolocator.openAppSettings,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isStarting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      color: AppColors.primary.s500,
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
                          color: AppColors.primary.s300,
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

          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + AppSpacing.md,
            left: AppSpacing.md,
            child: FloatingActionButton.small(
              heroTag: 'recordBack',
              onPressed: () => context.pop(),
              backgroundColor: AppColors.neutral.s100,
              foregroundColor: AppColors.neutral.s900,
              child: const Icon(Icons.arrow_back),
            ),
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
                      Text(
                        'Where are you heading?',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.neutral.s900,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      SizedBox(
                        width: double.infinity,
                        child: PingoButton(
                          onPressed: _handleStartRecording,
                          isLoading: _isStarting,
                          label: 'Record route',
                          icon: Icons.circle,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Switch to Explore Tab (Map)
                            context.go(RoutePaths.explore);
                          },
                          icon: const Icon(Icons.map_outlined, size: 20),
                          label: const Text('Create map manually'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.neutral.s900,
                            side: BorderSide(color: AppColors.neutral.s300),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.offline_pin_outlined,
                            size: 16,
                            color: AppColors.neutral.s500,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Offline ready',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.neutral.s500),
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
                                    ?.copyWith(color: AppColors.neutral.s500),
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
                            color: AppColors.neutral.s300,
                          ),
                          Column(
                            children: [
                              Text(
                                'DISTANCE',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: AppColors.neutral.s500),
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
                          // Pause / Resume
                          Expanded(
                            child: OutlinedButton(
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
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppSpacing.md),
                                side: BorderSide(color: AppColors.neutral.s300),
                                foregroundColor: AppColors.neutral.s900,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSpacing.lg),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(recordState.isPaused
                                      ? Icons.play_arrow
                                      : Icons.pause),
                                  const SizedBox(height: 4),
                                  Text(recordState.isPaused
                                      ? 'Resume'
                                      : 'Pause'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          // Stop
                          Expanded(
                            child: PingoButton(
                              onPressed: () async {
                                setState(() => _isStopping = true);
                                try {
                                  await ref
                                      .read(recordControllerProvider.notifier)
                                      .stopRecording();
                                  if (context.mounted) {
                                    context.go(RoutePaths.journeySummary
                                        .replaceFirst(
                                            ':id',
                                            recordState.journeyId?.toString() ??
                                                '0'));
                                  }
                                } finally {
                                  if (mounted) {
                                    setState(() => _isStopping = false);
                                  }
                                }
                              },
                              label: 'Finish',
                              isLoading: _isStopping,
                              icon: Icons.stop,
                              backgroundColor: AppColors.error.s500,
                              foregroundColor: Colors.white,
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
