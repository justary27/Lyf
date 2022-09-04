class UserEndpoints {
  UserEndpoints._();
  static const List<String> signUp = ["signUp", ""];
  static const List<String> login = ["logIn", ""];

  static List<String> deactivate(String userId) {
    return [userId, "deactivate", ""];
  }

  static List<String> delete(String userId) {
    return [userId, "delete", ""];
  }
}
