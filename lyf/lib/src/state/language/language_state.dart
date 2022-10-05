import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageNotifier = StateNotifierProvider<LanguageNotifier, Locale>((ref) {
  return LanguageNotifier(ref.read);
});

class LanguageNotifier extends StateNotifier<Locale> {
  final Reader read;
  Locale? previousState;

  LanguageNotifier(this.read, [Locale? initLanguage])
      : super(initLanguage ?? Locale(Platform.localeName.substring(0, 2)));

  Locale getCurrentState() {
    return state;
  }

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
