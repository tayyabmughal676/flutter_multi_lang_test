// Created by Tayyab Mughal on 12/03/2023.
// Tayyab Mughal
// tayyabmughal676@gmail.com
// © 2022-2023  - All Rights Reserved

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LANGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String SPANISH = 'es';
const String FRENCH = 'fr';
const String ITALIAN = 'it';
const String CHINESE = 'ch';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

/// Locale
Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, "");
    case SPANISH:
      return const Locale(SPANISH, "");
    case FRENCH:
      return const Locale(FRENCH, "");
    case ITALIAN:
      return const Locale(ITALIAN, "");
    // case CHINESE:
    //   return const Locale(CHINESE, "");
    default:
      return const Locale(ENGLISH, "");
  }
}

/// return translation
AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
