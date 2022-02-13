//API endpoints.
class ApiEndpoints {
  static String mainDomain =
      '10.38.1.92:8000'; //'192.168.21.43:8000'; /* '10.61.109.245:8000';*/'192.168.21.255';
  static String signUp = "http://$mainDomain/signUp/";
  static String signUpEmailError =
      "UNIQUE constraint failed: User_lyfuser.email";
  static String signUpUsernameError =
      "UNIQUE constraint failed: User_lyfuser.username";

  static String logIn = "http://$mainDomain/logIn/";

  static String getUserData(String userId) => "http://$mainDomain/$userId/get/";

  static String deactivateAccount(String userId) =>
      "http://$mainDomain/$userId/deactivate/";

  static String getAllTodos(String userId) =>
      "http://$mainDomain/$userId/todos/";

  static String createTodo(String userId) =>
      "http://$mainDomain/$userId/todos/create/";

  static String updateTodo(String userId, String entryId) =>
      "http://$mainDomain/$userId/todos/$entryId/update/";

  static String getAllEntries(String userId) =>
      "http://$mainDomain/$userId/diaryEntries/";

  static String createEntry(String userId) =>
      "http://$mainDomain/$userId/diaryEntries/create/";

  static String updateEntry(String userId, String entryId) =>
      "http://$mainDomain/$userId/diaryEntries/$entryId/update/";

  static String deleteEntry(String userId, String entryId) =>
      "http://$mainDomain/$userId/diaryEntries/$entryId/delete/";

  static String deleteTodo(userId, String entryId) =>
      "http://$mainDomain/$userId/todos/$entryId/delete/";
}
