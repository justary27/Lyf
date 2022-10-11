import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/state/language/language_state.dart';
import 'package:lyf/src/state/theme/theme_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import './global/variables.dart';
import './routes/routing.dart';
import './utils/handlers/device_handler.dart';
import './utils/helpers/screen_helper.dart';

import 'dart:io' show Platform;

/// The Root Widget for the App corresponding
/// to the respective platforms.
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

    /// Set App Orientation according to the device size.
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
    final appTheme = ref.watch(themeNotifier);
    final appLanguage = ref.watch(languageNotifier);
    switch (Platform.operatingSystem) {
      case "android":
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentScope = FocusScope.of(context);
            if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: MaterialApp.router(
            title: 'Lyf',
            debugShowCheckedModeBanner: false,
            theme: appTheme.themeData,
            scaffoldMessengerKey: snackKey,
            routerDelegate: goRouter.routerDelegate,
            routeInformationParser: goRouter.routeInformationParser,
            locale: appLanguage,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('hi', ''),
              Locale('es', ''),
              Locale('fr', ''),
            ],
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
          child: CupertinoApp.router(
            title: 'Lyf',
            debugShowCheckedModeBanner: false,
            routerDelegate: goRouter.routerDelegate,
            routeInformationParser: goRouter.routeInformationParser,
            locale: appLanguage,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('hi', ''),
              Locale('es', ''),
              Locale('fr', ''),
            ],
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
          child: MaterialApp.router(
            title: 'Lyf',
            debugShowCheckedModeBanner: false,
            theme: appTheme.themeData,
            scaffoldMessengerKey: snackKey,
            routerDelegate: goRouter.routerDelegate,
            routeInformationParser: goRouter.routeInformationParser,
            locale: appLanguage,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('hi', ''),
              Locale('es', ''),
              Locale('fr', ''),
            ],
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
