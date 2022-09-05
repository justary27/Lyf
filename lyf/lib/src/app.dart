import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './global/variables.dart';
import './routes/routing.dart';
import './themes/themes.dart';
import './state/firebase/link_state.dart';
import './utils/handlers/device_handler.dart';
import './utils/helpers/screen_helper.dart';

import 'dart:io' show Platform;

class Lyf extends ConsumerStatefulWidget {
  const Lyf({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LyfState();
}

class _LyfState extends ConsumerState<Lyf> with WidgetsBindingObserver {
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
    FirebaseDynamicLinks.instance.onLink.listen(
      (event) {
        ref.read(deepLinkNotifier.notifier).addError(event.link.path);
      },
    );
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
    switch (Platform.operatingSystem) {
      case "android":
        return GestureDetector(
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
            scaffoldMessengerKey: snackKey,
          ),
        );
      case "ios":
        return GestureDetector(
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
        );

      default:
        return GestureDetector(
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
            scaffoldMessengerKey: snackKey,
          ),
        );
    }
    // if (Platform.isIOS) {
    //   return GestureDetector(
    //     onTap: () {
    //       FocusScopeNode currentScope = FocusScope.of(context);
    //       if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    //         FocusManager.instance.primaryFocus!.unfocus();
    //       }
    //     },
    //     child: CupertinoApp(
    //       title: 'Lyf',
    //       debugShowCheckedModeBanner: false,
    //       initialRoute: (loginState) ? "/home" : "/welcome",
    //       onGenerateRoute: RouteManager.generateRoute,
    //     ),
    //   );
    // } else {
    //   return GestureDetector(
    //     onTap: () {
    //       FocusScopeNode currentScope = FocusScope.of(context);
    //       if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    //         FocusManager.instance.primaryFocus!.unfocus();
    //       }
    //     },
    //     child: MaterialApp(
    //       title: 'Lyf',
    //       debugShowCheckedModeBanner: false,
    //       theme: monochromeTheme,
    //       initialRoute: (loginState) ? "/home" : "/welcome",
    //       onGenerateRoute: RouteManager.generateRoute,
    //     ),
    //   );
    // }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
