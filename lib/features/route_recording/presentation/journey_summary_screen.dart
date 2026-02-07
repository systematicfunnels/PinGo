import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:pingo/core/domain/models/content_visibility.dart';
import 'package:pingo/core/routing/route_paths.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/features/route_recording/domain/models/journey.dart';
import 'package:pingo/features/route_recording/data/repositories/journey_repository_impl.dart';

class JourneySummaryScreen extends ConsumerStatefulWidget {
  final int journeyId;

  const JourneySummaryScreen({super.key, required this.journeyId});

  @override
  ConsumerState<JourneySummaryScreen> createState() => _JourneySummaryScreenState();
}

class _JourneySummaryScreenState extends ConsumerState<JourneySummaryScreen> {
  late TextEditingController _nameController;
  ContentVisibility _visibility = ContentVisibility.private;
  bool _isLoading = true;
  Journey? _journey;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadJourney();
  }

  Future<void> _loadJourney() async {
    final repository = ref.read(journeyRepositoryProvider);
    final journey = await repository.getJourneyById(widget.journeyId);
    
    if (mounted) {
      setState(() {
        _journey = journey;
        if (journey != null) {
          _nameController.text = journey.name ?? '';
          _visibility = journey.visibility;
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _saveJourney() async {
    if (_journey == null) return;

    final updatedJourney = _journey!.copyWith(
      name: _nameController.text.trim().isEmpty ? 'My Journey' : _nameController.text.trim(),
      visibility: _visibility,
    );

    final repository = ref.read(journeyRepositoryProvider);
    await repository.updateJourney(updatedJourney);

    if (mounted) {
      context.go(RoutePaths.library);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _buildStat(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontFamily: 'Serif',
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyButton(String label, IconData icon, ContentVisibility visibility) {
    final isSelected = _visibility == visibility;
    return InkWell(
      onTap: () {
        setState(() {
          _visibility = visibility;
        });
        // If it's the final action in React, we might want to save here?
        // React has buttons that navigate. Here we select and then maybe need a "Done" button or these buttons ARE the save action.
        // React: "Keep private" -> onNavigate('my-maps'). "Share" -> onNavigate('share-confirmation').
        // So they act as "Save and Continue".
        _saveJourney();
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppColors.primary : AppColors.textPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_journey == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Journey not found')),
      );
    }

    final routePoints = _journey!.routePoints
        .map((p) => LatLng(p[0], p[1]))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Map Preview (Top)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 350,
            child: FlutterMap(
              options: MapOptions(
                initialCameraFit: CameraFit.bounds(
                  bounds: LatLngBounds.fromPoints(
                      routePoints.isNotEmpty ? routePoints : [const LatLng(0, 0)]),
                  padding: const EdgeInsets.all(60),
                ),
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.none,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.pingo',
                ),
                if (routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: routePoints,
                        color: AppColors.primary,
                        strokeWidth: 4.0,
                      ),
                    ],
                  ),
              ],
            ),
          ),
          
          // Back Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: CircleAvatar(
              backgroundColor: AppColors.surface,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () => context.pop(),
              ),
            ),
          ),

          // Content
          Positioned.fill(
            top: 320,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Stats Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Journey complete',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildStat(context, 'Distance',
                                  '${(_journey!.totalDistance / 1000).toStringAsFixed(2)} km'),
                              _buildStat(context, 'Pins', '0'),
                              _buildStat(context, 'Duration',
                                  '${(_journey!.durationSeconds / 60).toStringAsFixed(0)}m'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Name Input
                    Text(
                      'Name this journey (optional)',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'Serif',
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Morning Trail Walk...',
                        hintStyle: TextStyle(color: AppColors.textTertiary.withValues(alpha: 0.5)),
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Privacy / Save Actions
                    Row(
                      children: [
                        Expanded(
                          child: _buildPrivacyButton(
                              'Keep private', Icons.lock_outline, ContentVisibility.private),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildPrivacyButton(
                              'Share', Icons.share_outlined, ContentVisibility.public),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
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
