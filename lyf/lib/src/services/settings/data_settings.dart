import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataService {
  late FlutterSecureStorage _storageInstance;
  final String _keyDataSettings = 'dsUuid';

  DataService(this._storageInstance);
}
