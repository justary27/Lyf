import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  PermissionManager._();
  static Future<int> _requestPermission(Permission permission) async {
    PermissionStatus status = await permission.request();
    if (status.isGranted) {
      return 2;
    } else if (status.isRestricted) {
      return 1;
    } else if (status.isDenied) {
      return -1;
    } else if (status.isPermanentlyDenied) {
      return -2;
    } else {
      return 0;
    }
  }

  static Future<int> requestLocationAccess() async {
    int permissionStatus = await _requestPermission(Permission.location);
    return permissionStatus;
  }

  static Future<int> requestStorageAccess() async {
    int permissionStatus = await _requestPermission(Permission.storage);
    return permissionStatus;
  }

  static Future<int> requestContactAccess() {
    return _requestPermission(Permission.contacts);
  }

  static Future<int> requestCameraAccess() {
    return _requestPermission(Permission.camera);
  }

  static Future<int> requestMicrophoneAccess() {
    return _requestPermission(Permission.microphone);
  }
}
