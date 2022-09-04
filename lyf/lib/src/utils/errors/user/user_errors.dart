class UserException implements Exception {
  final String errorMsg;

  UserException(this.errorMsg);

  @override
  String toString() {
    return "UserException: $errorMsg";
  }
}
