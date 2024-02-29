import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LanguageTranslation {
  late Locale locale;
  static Map<dynamic, dynamic> _localizedValues = Map();

  LanguageTranslation(Locale locale) {
    this.locale = locale;
    _localizedValues = Map();
  }

  static LanguageTranslation? of(BuildContext context) {
    return Localizations.of<LanguageTranslation>(context, LanguageTranslation);
  }

  String value(String key) {
    return _localizedValues[key] ?? '** $key not found';
  }

  static Future<LanguageTranslation> load(Locale locale) async {
    LanguageTranslation translations = LanguageTranslation(locale);
    String jsonContent = await rootBundle
        .loadString("assets/locale/${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translations;
  }

  get currentLanguage => locale.languageCode;
}
