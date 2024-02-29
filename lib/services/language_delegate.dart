import 'package:flutter/material.dart';
import 'package:movie_app/services/language_translation.dart';

class TranslationsDelegate extends LocalizationsDelegate<LanguageTranslation> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'id'].contains(locale.languageCode);

  @override
  Future<LanguageTranslation> load(Locale locale) =>
      LanguageTranslation.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => false;
}
