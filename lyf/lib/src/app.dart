import 'package:flutter/material.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/themes/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyf',
      debugShowCheckedModeBanner: false,
      theme: monochromeTheme,
      initialRoute: (loginState) ? "/home" : "/welcome",
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}
