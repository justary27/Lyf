import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountsService {
  late FlutterSecureStorage _storageInstance;
  final String _keyAccountSettings = 'asUuid';

  AccountsService(this._storageInstance);
}
