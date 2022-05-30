import 'package:flutter/material.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/services/firebase/auth_service.dart';
import 'package:lyf/src/services/user.dart';
import 'package:lyf/src/utils/api/user_api.dart';
import './src/app.dart';
import 'src/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  creds = await getCredentials();
  await login(creds);
  runApp(const Lyf());
}

Future<void> login(Map<String, String?>? creds) async {
  if (creds == null) {
    loginState = false;
  } else {
    try {
      LyfUser? authenticatedUser = await UserApiClient.logIn(creds);
      if (authenticatedUser != null) {
        currentUser = authenticatedUser;
        UserCredentials.setCredentials(
          currentUser.email,
          currentUser.password,
          currentUser.userName,
        );
        await FireAuth.logIn(creds: creds);
        loginState = true;
      }
    } catch (e) {
      loginState = false;
    }
  }
}

Future<Map<String, String?>?> getCredentials() async {
  Map<String, String?>? response = await UserCredentials.getCredentials();
  if (response != null) {
    return response;
  } else {
    return null;
  }
}
