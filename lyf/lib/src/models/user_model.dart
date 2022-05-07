import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/services/http.dart';
import 'package:lyf/src/services/user.dart';

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
  dynamic authHeader() {
    return {
      'Authorization': "Token " + token.toString(),
    };
  }

  static logIn(http.Client logInClient, Map<String, String?>? creds) async {
    http.Response response;
    print(creds);
    if (creds != null) {
      try {
        response = await logInClient.post(Uri.parse(ApiEndpoints.logIn), body: {
          'username': creds['email'],
          'password': creds['password'],
        });
        if (response.statusCode == 401) {
          loginState = false;
        } else if (response.statusCode == 200) {
          loginState = true;
          Map body = json.decode(response.body);
          currentUser = LyfUser(
            creds['email']!,
            creds['password']!,
            body['token'],
            body['username'],
            body['userId'],
          );
          creds = {
            'email': currentUser.email,
            'password': currentUser.password,
            'username': currentUser.username,
          };
          if (body['isActive'] == 'True') {
            currentUser.isActive = true;
          } else {
            currentUser.isActive = false;
          }
        }
        loginState = true;
        print("Logged in");
        UserCredentials.setCredentials(
            currentUser.email, currentUser.password, currentUser.userName);
      } catch (e) {
        log(e.toString());
        loginState = false;
      }
    } else {
      loginState = false;
    }
  }

  static Future<int> signUp(
      http.Client signUpClient, Map<String, String> signUpcreds) async {
    http.Response response;
    try {
      response = await signUpClient.post(Uri.parse(ApiEndpoints.signUp), body: {
        'email': signUpcreds['email'],
        'username': signUpcreds['username'],
        'password': signUpcreds['password'],
      });
      if (response.statusCode == 400) {
        print(response.body);
        loginState = false;
        if (json.decode(response.body) == ApiEndpoints.signUpEmailError) {
        } else if (response.body == ApiEndpoints.signUpUsernameError) {
          print(response.body);
        }
      } else if (response.statusCode == 200) {
        loginState = true;
        Map body = json.decode(response.body);
        currentUser = LyfUser(
          signUpcreds['email']!,
          signUpcreds['password']!,
          body['token'],
          body['username'],
          body['userId'],
        );
        if (body['isActive'] == 'True') {
          currentUser.isActive = true;
        } else {
          currentUser.isActive = false;
        }
      }
      return response.statusCode;
    } catch (e) {
      log(e.toString());
      loginState = false;
      return -1;
    }
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
