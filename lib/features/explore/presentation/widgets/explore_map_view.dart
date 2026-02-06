import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pingo/core/domain/models/pin_type.dart';
import 'package:pingo/core/presentation/widgets/organisms/pingo_pin_marker.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/elevation.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/pins/presentation/controllers/pins_controller.dart';
import 'package:pingo/features/pins/presentation/widgets/pin_editor_sheet.dart';
import 'package:pingo/features/pins/presentation/widgets/pin_details_sheet.dart';
import 'package:pingo/features/pins/domain/models/pin.dart';
import 'package:pingo/features/map/presentation/map_controller.dart' as app_map;

class ExploreMapView extends ConsumerStatefulWidget {
  const ExploreMapView({super.key});

  @override
  ConsumerState<ExploreMapView> createState() => _ExploreMapViewState();
}

class _ExploreMapViewState extends ConsumerState<ExploreMapView> {
  final MapController _mapController = MapController();
  bool _hasMovedToUser = false;

  PingoPinMarkerType _getPinType(PinType type) {
    switch (type) {
      case PinType.memory:
        return PingoPinMarkerType.place; // Memory maps to Place
      case PinType.safety:
        return PingoPinMarkerType.safety;
      case PinType.landmark:
        return PingoPinMarkerType.place; // Landmark maps to Place
      case PinType.restroom:
        return PingoPinMarkerType.place; // Restroom maps to Place
      case PinType.water:
        return PingoPinMarkerType
            .food; // Water maps to Food (or similar utility)
      case PinType.scenic:
        return PingoPinMarkerType.story; // Scenic maps to Story
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(app_map.mapControllerProvider);
    final pinsAsync = ref.watch(pinsControllerProvider);

    // Handle initial user location move without blocking
    ref.listen(app_map.mapControllerProvider, (previous, next) {
      next.whenData((position) {
        if (position != null && !_hasMovedToUser) {
          _mapController.move(
            LatLng(position.latitude, position.longitude),
            15.0,
          );
          _hasMovedToUser = true;
        }
      });
    });

    final LatLng initialCenter = locationAsync.value != null
        ? LatLng(locationAsync.value!.latitude, locationAsync.value!.longitude)
        : const LatLng(51.509364, -0.128928); // Default London

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: initialCenter,
            initialZoom: 15.0,
            interactionOptions: const InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            onTap: (_, __) {
              // Handle tap on empty area if needed (e.g. close custom overlays)
            },
            onLongPress: (tapPosition, point) {
              HapticFeedback.selectionClick();
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
                if (locationAsync.value != null)
                  Marker(
                    point: LatLng(locationAsync.value!.latitude,
                        locationAsync.value!.longitude),
                    width: 64,
                    height: 64,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary.s500.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.my_location,
                        color: AppColors.primary.s500,
                        size: AppSpacing.xxl,
                      ),
                    ),
                  ),
                // Pins Markers
                ...pinsAsync.maybeWhen(
                  data: (pins) => pins
                      .map((pin) => Marker(
                            point: LatLng(pin.latitude, pin.longitude),
                            width:
                                64, // PingoPinMarker handles internal sizing, but Marker needs a container size
                            height: 64,
                            child: Center(
                              child: PingoPinMarker(
                                type: _getPinType(pin.type),
                                isDraft: pin.isDraft,
                                isSynced: pin.isSynced,
                                isSensitive:
                                    false, // Assuming default for now unless Pin has this prop
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  if (pin.isDraft) {
                                    _showPinEditor(
                                        LatLng(pin.latitude, pin.longitude),
                                        pinToEdit: pin);
                                  } else {
                                    _showPinDetails(context, pin);
                                  }
                                },
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
        // Loading Indicator (Non-blocking)
        if (locationAsync.isLoading && !_hasMovedToUser)
          Positioned(
            top: AppSpacing.lg,
            right: AppSpacing.lg,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: AppElevation.floating,
                ),
                child: const SizedBox(
                  width: AppSpacing.xl,
                  height: AppSpacing.xl,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showPinEditor(LatLng point, {Pin? pinToEdit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PinEditorSheet(
        initialLat: point.latitude,
        initialLng: point.longitude,
        pinToEdit: pinToEdit,
      ),
    );
  }

  void _showPinDetails(BuildContext context, Pin pin) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => PinDetailsSheet(pin: pin),
    );
  }
}
