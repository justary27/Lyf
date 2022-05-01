import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/themes/themes.dart';
import 'dart:io' show Platform;

class Lyf extends StatelessWidget {
  const Lyf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoApp(
        title: 'Lyf',
        debugShowCheckedModeBanner: false,
        initialRoute: (loginState) ? "/home" : "/welcome",
        onGenerateRoute: RouteManager.generateRoute,
      );
    } else {
      return MaterialApp(
        title: 'Lyf',
        debugShowCheckedModeBanner: false,
        theme: monochromeTheme,
        initialRoute: (loginState) ? "/home" : "/welcome",
        onGenerateRoute: RouteManager.generateRoute,
      );
    }
  }
}
