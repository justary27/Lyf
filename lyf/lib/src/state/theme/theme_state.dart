import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/constants/theme_constants.dart';
import 'package:lyf/src/constants/widget_constants.dart';
import 'package:lyf/src/global/variables.dart';
import 'package:lyf/src/utils/helpers/theme_helper.dart';

final themeNotifier = StateNotifierProvider<ThemeNotifier, ThemeHelper>((ref) {
  return ThemeNotifier(ref.read);
});

final widgetNotifier = Provider<Widget?>(((ref) {
  ThemeHelper theme = ref.watch(themeNotifier);
  return widgetConstants[theme];
}));

class ThemeNotifier extends StateNotifier<ThemeHelper> {
  final Reader read;
  ThemeHelper? previousState;

  ThemeNotifier(this.read, [ThemeHelper? initColor])
      : super(initColor ?? themeConstants[themeCode]["theme"]);

  ThemeHelper getCurrentState() {
    return state;
  }

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
