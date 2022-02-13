import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BillingSettings {
  late FlutterSecureStorage _storageInstance;
  final String _keyBillingSettings = 'bsUuid';

  BillingSettings(this._storageInstance);
}
