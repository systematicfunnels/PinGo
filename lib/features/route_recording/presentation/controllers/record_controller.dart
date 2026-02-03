import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/journey.dart';
import '../../data/repositories/journey_repository_impl.dart';

part 'record_controller.g.dart';

// State class for the recorder
class RecorderState {
  final bool isRecording;
  final bool isPaused;
  final List<LatLng> currentPath;
  final Duration duration;
  final double distance; // in meters
  final DateTime? startTime;

  const RecorderState({
    this.isRecording = false,
    this.isPaused = false,
    this.currentPath = const [],
    this.duration = Duration.zero,
    this.distance = 0,
    this.startTime,
  });

  RecorderState copyWith({
    bool? isRecording,
    bool? isPaused,
    List<LatLng>? currentPath,
    Duration? duration,
    double? distance,
    DateTime? startTime,
  }) {
    return RecorderState(
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
    return const RecorderState();
  }

  Future<void> startRecording() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Handle permission error
      return;
    }

    state = state.copyWith(
      isRecording: true,
      isPaused: false,
      startTime: DateTime.now(),
      currentPath: [],
      distance: 0,
      duration: Duration.zero,
    );

    _startTimer();
    _startLocationUpdates();
  }

  Future<int?> stopRecording() async {
    _positionStream?.cancel();
    _timer?.cancel();

    int? journeyId;
    if (state.currentPath.isNotEmpty) {
      journeyId = await _saveJourney();
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
    });
  }

  Future<int> _saveJourney() async {
    final repository = ref.read(journeyRepositoryProvider);
    final journey = Journey(
      id: 0, // Auto-increment
      startTime: state.startTime ?? DateTime.now(),
      endTime: DateTime.now(),
      routePoints: state.currentPath.map((p) => [p.latitude, p.longitude]).toList(),
      totalDistance: state.distance,
      durationSeconds: state.duration.inSeconds,
    );
    return await repository.saveJourney(journey);
  }
}
