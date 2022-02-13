import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationSettings {
  late FlutterSecureStorage _storageInstance;
  final String _keyNotificationsSettings = 'nsUuid';

  NotificationSettings(this._storageInstance);
}
