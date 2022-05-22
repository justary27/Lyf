import 'dart:developer';

class EmailAlreadyExists implements Exception {
  String cause;

  EmailAlreadyExists(this.cause) {
    log(cause);
  }
}
