import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HelpSettings {
  late FlutterSecureStorage _storageInstance;
  final String _keyHelpSettings = 'hsUuid';

  HelpSettings(this._storageInstance);
}
