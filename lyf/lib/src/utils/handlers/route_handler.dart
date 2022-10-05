class RouteHandler {
  RouteHandler._();

  static const String splash = "/splash";
  static const String auth = "/auth";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String home = "/";
  static const String todo = "/todo";
  static const String createTodo = "/todo/add";
  static const String diary = "/diary";
  static const String createDiary = "/diary/add";
  static const String avatar = "/avatar";
  static const String settings = "/settings";
  static const String accountSettings = "/settings/account";
  static const String dataSettings = "/settings/data";
  static const String helpSettings = "/settings/help";
  static const String notificationSettings = "/settings/notifications";
  static const String themeSettings = "/settings/themes";
  static const String languageSettings = "/settings/language";
  static const String inviteSettings = "/settings/invite";

  static String viewDiary(String uuid) => "/diary/$uuid";
  static String viewTodo(String uuid) => "/todo/$uuid";
}
