import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/pins/presentation/widgets/pin_editor_sheet.dart';
import 'map_controller.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(mapControllerProvider);
    final pinsAsync = ref.watch(pinsControllerProvider);

    return Scaffold(
      body: locationAsync.when(
        data: (position) {
          // Default center (London) if position is null
          final center = position != null
              ? LatLng(position.latitude, position.longitude)
              : const LatLng(51.509364, -0.128928);

          return FlutterMap(
            options: MapOptions(
              initialCenter: center,
              initialZoom: 15.0,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
              onLongPress: (tapPosition, point) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => PinEditorSheet(
                    initialLat: point.latitude,
                    initialLng: point.longitude,
                  ),
                );
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
                                child: const Icon(
                                  Icons.location_on,
                                  color: AppColors.secondary,
                                  size: 40,
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
              const SizedBox(height: 16),
              Text(
                'Could not load map.\nPlease check location permissions.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              TextButton(
                onPressed: () => ref.refresh(mapControllerProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.refresh(mapControllerProvider),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.primary,
        child: const Icon(Icons.my_location),
      ),
    );
  }

  void _showPinDetails(
      BuildContext context, String? title, String? description) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? 'Untitled Pin',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            if (description != null && description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
