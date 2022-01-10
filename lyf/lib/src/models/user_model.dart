class LyfUser {
  late String email;
  late String password;
  late String token;
  late String username;
  late String userId;
  late String pfpLink;
  late bool isActive;
  late bool isProUser;

  get userName => username;
  get userID => userId;
  dynamic authHeader() {
    return {
      'Authorization': "Token " + token.toString(),
    };
  }
}
