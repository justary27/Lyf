import 'package:lyf/src/utils/enums/error_type.dart';

class DiaryException implements Exception {
  final String errorMsg;
  final ErrorType? errorType;

  DiaryException(
    this.errorMsg, {
    this.errorType,
  });

  @override
  String toString() {
    return "DiaryException: $errorMsg";
  }
}
