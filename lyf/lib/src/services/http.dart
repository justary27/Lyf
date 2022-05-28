//API endpoints.
class ApiEndpoints {
  static const String mainDomain = 'http://192.168.29.43:8000';
  // static const String mainDomain = 'http://10.38.1.92:8000';
  // static const String mainDomain = 'https://cdn-lyf.herokuapp.com';
  // 'http://192.168.21.43:8000'; /* 'http://10.61.109.245:8000';*/'192.168.21.255';
  static const String signUp = "$mainDomain/signUp/";
  static const String signUpEmailError =
      "UNIQUE constraint failed: User_lyfuser.email";
  static const String signUpUsernameError =
      "UNIQUE constraint failed: User_lyfuser.username";

  static const String logIn = "$mainDomain/logIn/";

  static String getUserData(String userId) => "$mainDomain/$userId/get/";

  static String deactivateAccount(String userId) =>
      "$mainDomain/$userId/deactivate/";

  static String getAllTodos(String userId) => "$mainDomain/$userId/todo/";

  static String createTodo(String userId) => "$mainDomain/$userId/todo/create/";

  static String updateTodo(String userId, String entryId) =>
      "$mainDomain/$userId/todo/$entryId/update/";

  static String getAllEntries(String userId) => "$mainDomain/$userId/diary/";

  static String createEntry(String userId) =>
      "$mainDomain/$userId/diary/create/";

  static String updateEntry(String userId, String entryId) =>
      "$mainDomain/$userId/diary/$entryId/update/";

  static String deleteEntry(String userId, String entryId) =>
      "$mainDomain/$userId/diary/$entryId/delete/";

  static String getEntryPdf(String userId, String entryId) =>
      "$mainDomain/$userId/diary/$entryId/$entryId.pdf";

  static String deleteTodo(userId, String entryId) =>
      "$mainDomain/$userId/todo/$entryId/delete/";
}
