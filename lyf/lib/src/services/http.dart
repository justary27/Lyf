//API endpoints.
class ApiEndpoints {
  // static const String mainDomain = 'http://10.61.105.201:8000';
  // static const String mainDomain = 'http://10.38.1.92:8000';
  static const String mainDomain = 'https://cdn-lyf.herokuapp.com';
  ////'http://192.168.21.43:8000'; /* 'http://10.61.109.245:8000';*/'192.168.21.255';
  static const String signUp = "$mainDomain/signUp/";
  static const String signUpEmailError =
      "UNIQUE constraint failed: User_lyfuser.email";
  static const String signUpUsernameError =
      "UNIQUE constraint failed: User_lyfuser.username";

  static const String logIn = "$mainDomain/logIn/";

  static String getUserData(String userId) => "$mainDomain/$userId/get/";

  static String deactivateAccount(String userId) =>
      "$mainDomain/$userId/deactivate/";

  static String getAllTodos(String userId) => "$mainDomain/$userId/todos/";

  static String createTodo(String userId) =>
      "$mainDomain/$userId/todos/create/";

  static String updateTodo(String userId, String entryId) =>
      "$mainDomain/$userId/todos/$entryId/update/";

  static String getAllEntries(String userId) =>
      "$mainDomain/$userId/diaryEntries/";

  static String createEntry(String userId) =>
      "$mainDomain/$userId/diaryEntries/create/";

  static String updateEntry(String userId, String entryId) =>
      "$mainDomain/$userId/diaryEntries/$entryId/update/";

  static String deleteEntry(String userId, String entryId) =>
      "$mainDomain/$userId/diaryEntries/$entryId/delete/";

  static String getEntryPdf(String userId, String entryId) =>
      "$mainDomain/$userId/diaryEntries/$entryId/$entryId.pdf";

  static String deleteTodo(userId, String entryId) =>
      "$mainDomain/$userId/todos/$entryId/delete/";
}
