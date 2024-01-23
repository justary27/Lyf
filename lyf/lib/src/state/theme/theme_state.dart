import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/constants/theme_constants.dart';
import 'package:lyf/src/constants/widget_constants.dart';
import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/utils/helpers/theme_helper.dart';

final themeNotifier =
    NotifierProvider<ThemeNotifier, ThemeHelper>(ThemeNotifier.new);

final widgetNotifier = Provider<Widget?>(((ref) {
  ThemeHelper theme = ref.watch(themeNotifier);
  return widgetConstants[theme];
}));

class ThemeNotifier extends Notifier<ThemeHelper> {
  // final Ref ref;
  ThemeHelper? previousState;

  // ThemeNotifier(this.ref, [ThemeHelper? initColor])
  //     : super(initColor ?? themeConstants[themeCode]["theme"]);

  @override
  ThemeHelper build([ThemeHelper? initTheme]) =>
      initTheme ?? themeConstants[themeCode]["theme"];

  void changeTheme(ThemeHelper newTheme) {
    _cacheState();

    try {
      state = newTheme;
    } catch (e) {
      handleException();
    }
  }

  void _cacheState() {
    previousState = state;
  }

  void _resetState() {
    if (previousState != null) {
      state = previousState!;
      previousState = null;
    }
  }

  void handleException() {
    _resetState();
  }
}
