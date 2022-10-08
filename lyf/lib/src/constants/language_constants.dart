import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Map> languageProvider(BuildContext context) {
  return [
    {
      'langName': AppLocalizations.of(context)!.english,
      'code': "EN",
      'locale': const Locale('en'),
    },
    {
      'langName': AppLocalizations.of(context)!.hindi,
      'code': "HI",
      'locale': const Locale('hi'),
    },
    {
      'langName': AppLocalizations.of(context)!.french,
      'code': "FR",
      'locale': const Locale('fr'),
    },
    {
      'langName': AppLocalizations.of(context)!.spanish,
      'code': "ES",
      'locale': const Locale('es'),
    }
  ];
}

List languageConstants = [
  {
    'langName': 'English',
    'desc': "",
    'locale': const Locale('en'),
  },
  {
    'langName': 'Hindi',
    'desc': "",
    'locale': const Locale('hi'),
  },
  {
    'langName': 'French',
    'desc': "",
    'locale': const Locale('fr'),
  },
  {
    'langName': 'Spanish',
    'desc': "",
    'locale': const Locale('es'),
  }
];
