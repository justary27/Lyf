import 'dart:developer';

class UserException implements Exception {
  final String errorMsg;

  UserException(this.errorMsg) {
    log("UserException: $errorMsg");
  }
}
