import 'dart:developer';

import '../../enums/error_type.dart';

class TodoException implements Exception {
  final String errorMsg;
  final ErrorType? errorType;

  TodoException(
    this.errorMsg, {
    this.errorType,
  });

  @override
  String toString() {
    return "TodoException: $errorMsg";
  }
}
