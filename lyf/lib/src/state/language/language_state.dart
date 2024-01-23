import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageNotifier = NotifierProvider<LanguageNotifier, Locale>(
  LanguageNotifier.new,
);

class LanguageNotifier extends Notifier<Locale> {
  Locale? previousState;

  @override
  Locale build([Locale? initLanguage]) =>
      initLanguage ?? Locale(Platform.localeName.substring(0, 2));

  void changeLanguage(Locale newLanguage) {
    _cacheState();

    try {
      state = newLanguage;
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
