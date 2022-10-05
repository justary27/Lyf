import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BillingService {
  late FlutterSecureStorage _storageInstance;
  final String _keyBillingSettings = 'bsUuid';

  BillingService(this._storageInstance);
}
