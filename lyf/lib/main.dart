import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import './src/app.dart';
import 'src/global/functions.dart';
import 'src/global/variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  creds = await getCredentials();
  await login(creds);
  runApp(const Lyf());
}
