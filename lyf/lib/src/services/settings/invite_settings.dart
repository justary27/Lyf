import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InviteSettings {
  late FlutterSecureStorage _storageInstance;
  final String _keyInviteSettings = 'isUuid';

  InviteSettings(this._storageInstance);
}
