import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LanguageService {
  late FlutterSecureStorage _storageInstance;
  final String _keyLanguageSettings = 'lsUuid';

  LanguageService(this._storageInstance);

  Future setLanguage(String language) async =>
      await _storageInstance.write(key: _keyLanguageSettings, value: language);

  Future<String?> getLanguage() async =>
      await _storageInstance.read(key: _keyLanguageSettings);
}
