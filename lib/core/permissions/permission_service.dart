import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../errors/app_error.dart';

part 'permission_service.g.dart';

// Permission handling service
class PermissionService {
  Future<bool> requestLocationPermission() async {
    try {
      final status = await Permission.location.request();
      return status.isGranted;
    } catch (e, stack) {
      throw PermissionError('Failed to request location permission', e, stack);
    }
  }

  Future<bool> checkLocationPermission() async {
    try {
      return await Permission.location.isGranted;
    } catch (e, stack) {
      throw PermissionError('Failed to check location permission', e, stack);
    }
  }

  Future<bool> requestCameraPermission() async {
    try {
      final status = await Permission.camera.request();
      return status.isGranted;
    } catch (e, stack) {
      throw PermissionError('Failed to request camera permission', e, stack);
    }
  }

  Future<bool> requestPhotosPermission() async {
    try {
      final status = await Permission.photos.request();
      return status.isGranted;
    } catch (e, stack) {
      throw PermissionError('Failed to request photos permission', e, stack);
    }
  }

  Future<void> openSettings() async {
    try {
      await openAppSettings();
    } catch (e, stack) {
      throw PermissionError('Failed to open app settings', e, stack);
    }
  }
}

@Riverpod(keepAlive: true)
PermissionService permissionService(Ref ref) {
  return PermissionService();
}
