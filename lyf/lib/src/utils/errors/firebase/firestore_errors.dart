import 'package:lyf/src/utils/enums/error_type.dart';

class FireStoreException implements Exception {
  final String errorMsg;
  final ErrorType? errorType;

  FireStoreException(
    this.errorMsg, {
    this.errorType,
  });

  @override
  String toString() {
    return "FireStoreException: $errorMsg";
  }
}
