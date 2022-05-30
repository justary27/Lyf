import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/services/http.dart';
import 'package:lyf/src/services/user.dart';
// import 'package:json_annotation/json_annotation.dart';
// import '../interface/json_object.dart';

/// ## LyfUser
///  Defining class of a user of the Lyf App.
class LyfUser {
  String email;
  String password;
  String token;
  String username;
  String userId;
  late String pfpLink;
  late bool isActive;
  late bool isProUser;

  // Constructor

  LyfUser(
    this.email,
    this.password,
    this.token,
    this.username,
    this.userId,
  );

  String get userName => username;
  String get userID => userId;
  Map<String, String> authHeader() {
    return {
      'Authorization': "Token " + token.toString(),
    };
  }

  static Future<int> deactivateAccount() async {
    http.Client deactivateClient = http.Client();
    http.Response response;
    try {
      response = await deactivateClient.put(
        Uri.parse(
          ApiEndpoints.deactivateAccount(currentUser.userId),
        ),
        headers: currentUser.authHeader(),
      );
      deactivateClient.close();
      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 401) {
        return 401;
      } else {
        return -1;
      }
    } catch (e) {
      log(e.toString());
      return -1;
    }
  }

  static deleteAccount() async {}
}

/// Default user created before logging in to the app.
final LyfUser guestUser = LyfUser(
  "guest@lyf.com",
  "lyfGuest",
  "1234567890",
  "Guest",
  "GuestLyf23456",
);
