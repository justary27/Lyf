import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'global/variables.dart';
import './routes/routing.dart';
import './themes/themes.dart';
import './utils/handlers/device_handler.dart';
import './utils/helpers/screen_helper.dart';

import 'dart:io' show Platform;

class Lyf extends StatefulWidget {
  const Lyf({Key? key}) : super(key: key);

  @override
  State<Lyf> createState() => _LyfState();
}

class _LyfState extends State<Lyf> with WidgetsBindingObserver {
  late AppLifecycleState _notification;

  @override
  void initState() {
    super.initState();
    DeviceHandler.setAppOrientationOptions(
      DeviceHandler.getDeviceType(
        deviceSize: logicalScreenSize,
      ),
    );
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
    });
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
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

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
