import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NotificationService {
  late FlutterSecureStorage _storageInstance;
  final String _keyNotificationsSettings = 'nsUuid';

  NotificationService(this._storageInstance);
}
