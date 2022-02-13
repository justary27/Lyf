import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountSettings {
  late FlutterSecureStorage _storageInstance;
  final String _keyAccountSettings = 'asUuid';

  AccountSettings(this._storageInstance);
}
