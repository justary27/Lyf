import 'dart:developer';

class TodoException implements Exception {
  final String errorMsg;

  TodoException(this.errorMsg) {
    print("TodoException: $errorMsg");
  }
}
