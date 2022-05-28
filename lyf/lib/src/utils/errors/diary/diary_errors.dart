import 'dart:developer';

class DiaryException implements Exception {
  final String errorMsg;

  DiaryException(this.errorMsg) {
    log("DiaryException: $errorMsg");
  }
}
