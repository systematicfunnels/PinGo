import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:pingo/core/presentation/widgets/molecules/pingo_button.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/config/constants.dart';
import 'package:pingo/core/presentation/utils/snackbar_utils.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/radius.dart';
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
    
    // If not recording, show Start Journey UI
    if (!recordState.isRecording) {
      return _buildStartJourney(context, ref);
    }

    // If recording, show Recording UI
    return _buildRecordingUI(context, ref, recordState);
  }

  Widget _buildStartJourney(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Where are you heading?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontFamily: 'Serif',
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Record route
            _buildSelectionCard(
              context,
              icon: Icons.map_outlined,
              title: 'Record route',
              description: 'Track your path as you move. Pins will be added along the way.',
              onTap: () {
                ref.read(recordControllerProvider.notifier).startRecording();
              },
            ),
            const SizedBox(height: 16),
            // Create manually
            _buildSelectionCard(
              context,
              icon: Icons.edit_outlined,
              title: 'Create map manually',
              description: 'Draw your route and add pins at your own pace.',
              onTap: () {
                context.go(RoutePaths.map);
              },
            ),
            const SizedBox(height: 24),
            // Offline indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 16, color: AppColors.textTertiary),
                const SizedBox(width: 8),
                Text(
                  'Works offline · Your journey will sync later',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontFamily: 'Serif',
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordingUI(
      BuildContext context, WidgetRef ref, RecorderState recordState) {
    final locationAsync = ref.watch(mapControllerProvider);
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
                urlTemplate: AppConstants.mapStyleUrl,
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
              // Current Location Marker
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
                          boxShadow: AppElevation.floating,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),

<<<<<<< HEAD
          // Top Status Card
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.danger,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Recording your journey',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatDistance(recordState.distance),
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Distance traveled',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _formatDuration(recordState.duration),
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            'Time elapsed',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textTertiary,
=======
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
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.neutral.s100,
                borderRadius: AppRadius.all16,
                boxShadow: AppElevation.floating,
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
                        child: PingoButton.primary(
                          onPressed: _handleStartRecording,
                          isLoading: _isStarting,
                          label: 'Record route',
                          leadingIcon: Icons.circle,
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
                                shape: const RoundedRectangleBorder(
                                  borderRadius: AppRadius.all16,
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
                            child: PingoButton.destructive(
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
                              leadingIcon: Icons.stop,
>>>>>>> 7bff084ce9060fcc732c36c2de38dd4d786fe41c
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Controls
          Positioned(
            left: 16,
            right: 16,
            bottom: 32,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Add Pin Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to Pin Creation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Pin Creation not implemented yet')),
                      );
                    },
                    icon: const Icon(Icons.add_location_alt_outlined, color: AppColors.primary),
                    label: const Text('Add pin at current location'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: AppColors.textPrimary,
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Pause and End Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (recordState.isPaused) {
                            ref.read(recordControllerProvider.notifier).resumeRecording();
                          } else {
                            ref.read(recordControllerProvider.notifier).pauseRecording();
                          }
                        },
                        icon: Icon(
                          recordState.isPaused ? Icons.play_arrow : Icons.pause,
                          color: AppColors.textPrimary,
                        ),
                        label: Text(recordState.isPaused ? 'Resume' : 'Pause'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.surface,
                          foregroundColor: AppColors.textPrimary,
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final journeyId = await ref
                              .read(recordControllerProvider.notifier)
                              .stopRecording();
                          if (context.mounted && journeyId != null) {
                            context.push(RoutePaths.journeySummary
                                .replaceFirst(':id', journeyId.toString()));
                          }
                        },
                        icon: const Icon(Icons.stop_rounded, color: Colors.white),
                        label: const Text('End journey'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
