import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemeSettings {
  late final FlutterSecureStorage _storageInstance;
  final String _keyThemeSettings = 'tsUuid';

  ThemeSettings(this._storageInstance);

  Future setTheme(String themeName) async =>
      await _storageInstance.write(key: _keyThemeSettings, value: themeName);

  Future<String?> getTheme() async =>
      await _storageInstance.read(key: _keyThemeSettings);
}
