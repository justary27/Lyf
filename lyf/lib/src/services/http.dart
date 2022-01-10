//API endpoints.
class ApiEndpoints {
  static String signUp = "http://192.168.156.43:8000/signUp/";
  static String signUpEmailError =
      "UNIQUE constraint failed: User_lyfuser.email";
  static String signUpUsernameError =
      "UNIQUE constraint failed: User_lyfuser.username";

  static String logIn = "http://192.168.156.43:8000/logIn/";

  static String getUserData(String userId) =>
      "http://192.168.156.43:8000/$userId/get/";

  static String getAllTodos(String userId) =>
      "http://192.168.156.43:8000/$userId/todos/";

  static String createTodo(String userId) =>
      "http://192.168.156.43:8000/$userId/todos/create/";

  static String updateTodo(String userId, String entryId) =>
      "http://192.168.156.43:8000/$userId/todos/$entryId/update/";

  static String getAllEntries(String userId) =>
      "http://192.168.156.43:8000/$userId/diaryEntries/";

  static String createEntry(String userId) =>
      "http://192.168.156.43:8000/$userId/diaryEntries/create/";

  static String updateEntry(String userId, String entryId) =>
      "http://192.168.156.43:8000/$userId/diaryEntries/$entryId/update/";

  static String deleteEntry(String userId, String entryId) =>
      "http://192.168.156.43:8000/$userId/diaryEntries/$entryId/delete/";

  static String deleteTodo(userId, String entryId) =>
      "http://192.168.156.43:8000/$userId/todos/$entryId/delete/";
}
