import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:pingo/core/config/constants.dart';
import 'package:pingo/core/theme/app_theme.dart';
import 'package:pingo/core/theme/spacing.dart';
import 'package:pingo/features/route_recording/domain/models/journey.dart';
import 'package:pingo/features/route_recording/data/repositories/journey_repository_impl.dart';

class MemoryReplayScreen extends ConsumerStatefulWidget {
  final int journeyId;

  const MemoryReplayScreen({super.key, required this.journeyId});

  @override
  ConsumerState<MemoryReplayScreen> createState() => _MemoryReplayScreenState();
}

class _MemoryReplayScreenState extends ConsumerState<MemoryReplayScreen> {
  Journey? _journey;
  bool _isLoading = true;
  bool _isPlaying = false;
  int _currentIndex = 0;
  Timer? _timer;
  double _speedMultiplier = 1.0;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _loadJourney();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadJourney() async {
    final repository = ref.read(journeyRepositoryProvider);
    final journey = await repository.getJourneyById(widget.journeyId);
    if (mounted) {
      setState(() {
        _journey = journey;
        _isLoading = false;
      });
    }
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _startTimer();
    } else {
      _timer?.cancel();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(
        Duration(milliseconds: (200 / _speedMultiplier).round()), (timer) {
      if (_journey == null || _journey!.routePoints.isEmpty) return;

      if (_currentIndex < _journey!.routePoints.length - 1) {
        setState(() {
          _currentIndex++;
        });
        _moveMap();
      } else {
        _timer?.cancel();
        setState(() {
          _isPlaying = false;
          _currentIndex = 0; // Reset or Stay? Let's stay for now, or reset.
        });
      }
    });
  }

  void _moveMap() {
    if (_journey != null && _journey!.routePoints.isNotEmpty) {
      final point = _journey!.routePoints[_currentIndex];
      _mapController.move(
          LatLng(point[0], point[1]), _mapController.camera.zoom);
    }
  }

  void _changeSpeed() {
    setState(() {
      if (_speedMultiplier == 1.0) {
        _speedMultiplier = 2.0;
      } else if (_speedMultiplier == 2.0) {
        _speedMultiplier = 5.0;
      } else {
        _speedMultiplier = 1.0;
      }
    });
    if (_isPlaying) {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_journey == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Journey not found')),
      );
    }

    final routePoints =
        _journey!.routePoints.map((p) => LatLng(p[0], p[1])).toList();

    if (routePoints.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Empty Journey')),
        body: const Center(child: Text('No route data available')),
      );
    }

    final currentPoint = routePoints[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Replay'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: routePoints.first,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: AppConstants.mapStyleUrl,
                userAgentPackageName: 'com.hemant.pingo',
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: routePoints,
                    color: AppColors.primary.s500.withValues(alpha: 0.5),
                    strokeWidth: 4.0,
                  ),
                  // Progress line
                  Polyline(
                    points: routePoints.take(_currentIndex + 1).toList(),
                    color: AppColors.primary.s500,
                    strokeWidth: 4.0,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: currentPoint,
                    width: AppSpacing.xxl,
                    height: AppSpacing.xxl,
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
                      child: const Icon(Icons.navigation,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            bottom: AppSpacing.xxl,
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                      onPressed: _togglePlay,
                      iconSize: 32,
                      color: AppColors.primary.s500,
                    ),
                    Expanded(
                      child: Slider(
                        value: _currentIndex.toDouble(),
                        min: 0,
                        max: (routePoints.length - 1).toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _currentIndex = value.toInt();
                          });
                          _moveMap();
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: _changeSpeed,
                      child: Text('${_speedMultiplier.toStringAsFixed(0)}x'),
                    ),
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
