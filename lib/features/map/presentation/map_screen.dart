import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pingo/core/domain/models/pin_type.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/map/presentation/unknown_place_sheet.dart';
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

          return Stack(
            children: [
              // Full-bleed Map
              FlutterMap(
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: 15.0,
                  interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
                  ),
                  onLongPress: (tapPosition, point) {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => UnknownPlaceSheet(
                        lat: point.latitude,
                        lng: point.longitude,
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
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: pin.type == PinType.safety
                                              ? AppColors.danger
                                              : AppColors.primary,
                                          size: 40,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black.withValues(alpha: 0.2),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                        orElse: () => [],
                      ),
                    ],
                  ),
                ],
              ),

              // Top Bar (Floating)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back Button (or Home if top level)
                        _MapFloatButton(
                          icon: Icons.arrow_back,
                          onTap: () {
                             // If we can pop, pop. Else go to feed.
                             if (context.canPop()) {
                               context.pop();
                             } else {
                               context.go(RoutePaths.homeFeed);
                             }
                          },
                        ),
                        
                        // Right Side Controls
                        Row(
                          children: [
                            _MapFloatButton(
                              icon: Icons.layers_outlined,
                              onTap: () {
                                // TODO: Layer switcher
                              },
                            ),
                            const SizedBox(width: 8),
                            _MapFloatButton(
                              icon: Icons.filter_list,
                              onTap: () {
                                // TODO: Filter
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom Hint Card
              Positioned(
                bottom: 24,
                left: 24,
                right: 24,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tap anywhere to explore',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textTertiary,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Long press to create a pin at any location',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary,
                            ),
                      ),
                    ],
                  ),
                ),
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


class _MapFloatButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapFloatButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        color: AppColors.textPrimary,
        onPressed: onTap,
      ),
    );
  }
}
