import 'package:permission_handler/permission_handler.dart';

// Permission handling service
class PermissionService {
  Future<bool> requestLocationPermission() async {
    final status = await Permission.location.request();
    return status.isGranted;
  }

  Future<bool> checkLocationPermission() async {
    return await Permission.location.isGranted;
  }
}
