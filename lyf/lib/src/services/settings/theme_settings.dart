import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ThemesService {
  late final FlutterSecureStorage _storageInstance;
  final String _keyThemeSettings = 'tsUuid';

  ThemesService(this._storageInstance);

  Future setTheme(String themeCode) async =>
      await _storageInstance.write(key: _keyThemeSettings, value: themeCode);

  Future<String?> getTheme() async =>
      await _storageInstance.read(key: _keyThemeSettings);
}
