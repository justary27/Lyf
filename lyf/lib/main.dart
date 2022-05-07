import 'package:flutter/material.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/services/firebase/auth_service.dart';
import 'package:lyf/src/services/user.dart';
import './src/app.dart';
import 'src/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  http.Client logInClient = http.Client();
  creds = await getCredentials();
  await login(creds, logInClient);
  logInClient.close();
  runApp(const Lyf());
}

login(Map<String, String?>? creds, http.Client logInClient) async {
  if (creds == null) {
    loginState = false;
  } else {
    try {
      await LyfUser.logIn(logInClient, creds);
      await FireAuth.logIn(creds: creds);
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
