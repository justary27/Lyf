import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InviteService {
  late FlutterSecureStorage _storageInstance;
  final String _keyInviteSettings = 'isUuid';

  InviteService(this._storageInstance);
}
