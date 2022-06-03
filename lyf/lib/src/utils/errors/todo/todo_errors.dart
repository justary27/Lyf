import 'dart:developer';

class TodoException implements Exception {
  final String errorMsg;

  TodoException(this.errorMsg) {
    log("TodoException: $errorMsg");
  }
}
