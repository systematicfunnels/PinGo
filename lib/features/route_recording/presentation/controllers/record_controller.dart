import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/journey.dart';
import '../../data/repositories/journey_repository_impl.dart';

part 'record_controller.g.dart';

// State class for the recorder
class RecorderState {
  final int? journeyId;
  final bool isRecording;
  final bool isPaused;
  final List<LatLng> currentPath;
  final Duration duration;
  final double distance; // in meters
  final DateTime? startTime;

  const RecorderState({
    this.journeyId,
    this.isRecording = false,
    this.isPaused = false,
    this.currentPath = const [],
    this.duration = Duration.zero,
    this.distance = 0,
    this.startTime,
  });

  RecorderState copyWith({
    int? journeyId,
    bool? isRecording,
    bool? isPaused,
    List<LatLng>? currentPath,
    Duration? duration,
    double? distance,
    DateTime? startTime,
  }) {
    return RecorderState(
      journeyId: journeyId ?? this.journeyId,
      isRecording: isRecording ?? this.isRecording,
      isPaused: isPaused ?? this.isPaused,
      currentPath: currentPath ?? this.currentPath,
      duration: duration ?? this.duration,
      distance: distance ?? this.distance,
      startTime: startTime ?? this.startTime,
    );
  }
}

@Riverpod(keepAlive: true)
class RecordController extends _$RecordController {
  StreamSubscription<Position>? _positionStream;
  Timer? _timer;

  @override
  RecorderState build() {
    // Clean up on dispose
    ref.onDispose(() {
      _positionStream?.cancel();
      _timer?.cancel();
    });

    // Attempt to restore active journey asynchronously
    // We can't await here, so we fire and forget, but update state when done
    Future(() => _restoreActiveJourney());

    return const RecorderState();
  }

  Future<void> _restoreActiveJourney() async {
    try {
      final repository = ref.read(journeyRepositoryProvider);

      final journey = await repository.getActiveJourney();

      if (journey != null) {
        // Fetch raw points
        final points = await repository.getJourneyRoutePoints(journey.id);
        final path = points.map((p) => LatLng(p[0], p[1])).toList();

        // Calculate distance if needed, or rely on journey.totalDistance
        // Assuming journey.totalDistance is updated periodically or we recalculate?
        // Let's use stored distance for now.

        state = state.copyWith(
          journeyId: journey.id,
          isRecording: true,
          isPaused: true, // Start paused to let user resume intentionally
          startTime: journey.startTime,
          currentPath: path,
          distance: journey.totalDistance,
          duration: Duration(seconds: journey.durationSeconds),
        );

        // Don't auto-resume, just restore state.
        // User will see "Paused" UI and can resume.
      }
    } catch (e) {
      // Ignore errors during restore
      debugPrint('Error restoring journey: $e');
    }
  }

  Future<LocationPermission> startRecording() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final requested = await Geolocator.requestPermission();
      if (requested == LocationPermission.denied ||
          requested == LocationPermission.deniedForever) {
        return requested;
      }
    } else if (permission == LocationPermission.deniedForever) {
      return permission;
    }

    // Initialize journey in DB
    final repository = ref.read(journeyRepositoryProvider);
    final startTime = DateTime.now();

    // Create initial journey entry
    final journey = Journey(
      id: 0,
      startTime: startTime,
      routePoints: [],
      totalDistance: 0,
      durationSeconds: 0,
    );

    final journeyId = await repository.saveJourney(journey);

    state = state.copyWith(
      journeyId: journeyId,
      isRecording: true,
      isPaused: false,
      startTime: startTime,
      currentPath: [],
      distance: 0,
      duration: Duration.zero,
    );

    _startTimer();
    _startLocationUpdates();

    return LocationPermission.whileInUse; // Or always
  }

  Future<int?> stopRecording() async {
    _positionStream?.cancel();
    _timer?.cancel();

    final journeyId = state.journeyId;
    if (journeyId != null) {
      await _updateFinalJourney(journeyId);
    }

    state = const RecorderState(); // Reset
    return journeyId;
  }

  void pauseRecording() {
    _positionStream?.pause();
    _timer?.cancel();
    state = state.copyWith(isPaused: true);
  }

  void resumeRecording() {
    _positionStream?.resume();
    _startTimer();
    state = state.copyWith(isPaused: false);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        duration: state.duration + const Duration(seconds: 1),
      );
    });
  }

  void _startLocationUpdates() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 5, // Update every 5 meters
    );

    _positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      final newPoint = LatLng(position.latitude, position.longitude);
      final List<LatLng> newPath = [...state.currentPath, newPoint];

      double addedDistance = 0;
      if (state.currentPath.isNotEmpty) {
        final lastPoint = state.currentPath.last;
        addedDistance = Geolocator.distanceBetween(
          lastPoint.latitude,
          lastPoint.longitude,
          newPoint.latitude,
          newPoint.longitude,
        );
      }

      state = state.copyWith(
        currentPath: newPath,
        distance: state.distance + addedDistance,
      );

      // Persist point to DB
      if (state.journeyId != null) {
        ref.read(journeyRepositoryProvider).insertJourneyPoint(
              state.journeyId!,
              position.latitude,
              position.longitude,
              alt: position.altitude,
              speed: position.speed,
              accuracy: position.accuracy,
              timestamp: position.timestamp,
            );
      }
    });
  }

  Future<void> _updateFinalJourney(int journeyId) async {
    final repository = ref.read(journeyRepositoryProvider);
    final journey = Journey(
      id: journeyId,
      startTime: state.startTime ?? DateTime.now(),
      endTime: DateTime.now(),
      routePoints:
          state.currentPath.map((p) => [p.latitude, p.longitude]).toList(),
      totalDistance: state.distance,
      durationSeconds: state.duration.inSeconds,
    );
    await repository.updateJourney(journey);
  }
}
