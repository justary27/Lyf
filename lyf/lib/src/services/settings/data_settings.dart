import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataSettings {
  late FlutterSecureStorage _storageInstance;
  final String _keyDataSettings = 'dsUuid';

  DataSettings(this._storageInstance);
}
