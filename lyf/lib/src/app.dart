import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/routes/routing.dart';
import 'package:lyf/src/themes/themes.dart';
import 'package:lyf/src/utils/handlers/device_handler.dart';
import 'package:lyf/src/utils/helpers/screen_helper.dart';

import 'dart:io' show Platform;

class Lyf extends StatelessWidget {
  const Lyf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DeviceHandler.setAppOrientationOptions(
      DeviceHandler.getDeviceType(
        deviceSize: logicalScreenSize,
      ),
    );
    if (Platform.isIOS) {
      return ProviderScope(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: CupertinoApp(
            title: 'Lyf',
            debugShowCheckedModeBanner: false,
            initialRoute: (loginState) ? "/home" : "/welcome",
            onGenerateRoute: RouteManager.generateRoute,
          ),
        ),
      );
    } else {
      return ProviderScope(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: MaterialApp(
            title: 'Lyf',
            debugShowCheckedModeBanner: false,
            theme: monochromeTheme,
            initialRoute: (loginState) ? "/home" : "/welcome",
            onGenerateRoute: RouteManager.generateRoute,
          ),
        ),
      );
    }
  }
}
