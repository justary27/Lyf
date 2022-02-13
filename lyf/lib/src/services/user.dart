import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserCredentials {
  static const _storageInstance = FlutterSecureStorage();
  static const _keyEmail = 'eUuid';
  static const _keyUsername = 'uUuid';

  static const _keyPassword = 'pUuid';

  static Future setEmail(String email) async =>
      await _storageInstance.write(key: _keyEmail, value: email);

  static Future<String?> getEmail() async =>
      await _storageInstance.read(key: _keyEmail);

  static Future setUsername(String username) async =>
      await _storageInstance.write(key: _keyUsername, value: username);

  static Future<String?> getUsername() async =>
      await _storageInstance.read(key: _keyUsername);

  static Future setPassword(String password) async =>
      await _storageInstance.write(key: _keyPassword, value: password);

  static Future<String?> getPassword() async =>
      await _storageInstance.read(key: _keyPassword);

  static Future setCredentials(
    String email,
    String password,
    String username,
  ) async {
    UserCredentials.setEmail(email);
    UserCredentials.setPassword(password);
    UserCredentials.setUsername(username);
  }

  static Future<Map<String, String?>?> getCredentials() async {
    String? email = await UserCredentials.getEmail();
    String? password = await UserCredentials.getPassword();
    String? username = await UserCredentials.getUsername();
    if (email != null && password != null && username != null) {
      return {
        'email': email,
        'password': password,
        'username': username,
      };
    } else {
      return null;
    }
  }

  static void deleteCredentials() async {
    _storageInstance.delete(key: _keyEmail);
    _storageInstance.delete(key: _keyPassword);
    _storageInstance.delete(key: _keyUsername);
  }
}
