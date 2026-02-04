import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pingo/core/domain/models/pin_type.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/pins/presentation/widgets/pin_editor_sheet.dart';
import 'map_controller.dart' as app_map;

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(app_map.mapControllerProvider);
    final pinsAsync = ref.watch(pinsControllerProvider);

    return Scaffold(
      body: locationAsync.when(
        data: (position) {
          // Default center (London) if position is null
          final center = position != null
              ? LatLng(position.latitude, position.longitude)
              : const LatLng(51.509364, -0.128928);

          return FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: center,
              initialZoom: 15.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
              onLongPress: (tapPosition, point) {
                _showPinEditor(point);
              },
            ),
            children: [
              TileLayer(
                // CartoDB Voyager - Clean, earth-tone friendly
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.pingo',
              ),
              MarkerLayer(
                markers: [
                  // Current Location Marker
                  if (position != null)
                    Marker(
                      point: LatLng(position.latitude, position.longitude),
                      width: 60,
                      height: 60,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.my_location,
                          color: AppColors.primary,
                          size: 30,
                        ),
                      ),
                    ),
                  // Pins Markers
                  ...pinsAsync.maybeWhen(
                    data: (pins) => pins
                        .map((pin) => Marker(
                              point: LatLng(pin.latitude, pin.longitude),
                              width: 50,
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  _showPinDetails(
                                      context, pin.title, pin.description);
                                },
                                behavior: HitTestBehavior.opaque,
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    pin.type == PinType.safety
                                        ? Icons.warning_rounded
                                        : Icons.location_on,
                                    color: pin.type == PinType.safety
                                        ? AppColors.danger
                                        : AppColors.secondary,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    orElse: () => [],
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline,
                  size: 48, color: AppColors.danger),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Could not load map.\nPlease check location permissions.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextButton(
                onPressed: () => ref.refresh(app_map.mapControllerProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'dropPinFab',
            onPressed: () {
              // Drop pin at center of map
              _showPinEditor(_mapController.camera.center);
            },
            backgroundColor: AppColors.secondary,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add_location_alt_outlined),
          ),
          const SizedBox(height: AppSpacing.md),
          FloatingActionButton(
            heroTag: 'myLocationFab',
            onPressed: () => ref.refresh(app_map.mapControllerProvider),
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.primary,
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }

  void _showPinEditor(LatLng point) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PinEditorSheet(
        initialLat: point.latitude,
        initialLng: point.longitude,
      ),
    );
  }

  void _showPinDetails(
      BuildContext context, String? title, String? description) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(AppSpacing.xl)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag Handle
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
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? 'Untitled Pin',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    if (description != null && description.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
