import 'package:lyf/src/utils/enums/error_type.dart';

class ServiceException implements Exception {
  final String errorMsg;
  final ErrorType? errorType;

  ServiceException(
    this.errorMsg, {
    this.errorType,
  });

  @override
  String toString() {
    return "ServiceException: $errorMsg";
  }
}
