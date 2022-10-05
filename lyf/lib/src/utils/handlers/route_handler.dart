class RouteHandler {
  RouteHandler._();

  static String splash = "/splash";
  static String auth = "/auth";
  static String login = "/login";
  static String signup = "/signup";
  static String home = "/";
  static String todo = "/todo";
  static String createTodo = "/todo/add";
  static String diary = "/diary";
  static String createDiary = "/diary/add";
  static String avatar = "/avatar";
  static String settings = "/settings";
  static String accountSettings = "/settings/account";
  static String dataSettings = "/settings/data";
  static String helpSettings = "/settings/help";
  static String notificationSettings = "/settings/notifications";
  static String themeSettings = "/settings/themes";
  static String languageSettings = "/settings/language";
  static String inviteSettings = "/settings/invite";

  static String viewDiary(String uuid) => "/diary/$uuid";
  static String viewTodo(String uuid) => "/todo/$uuid";
}
