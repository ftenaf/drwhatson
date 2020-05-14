import 'package:flutter/material.dart';

class LanguageHelper extends ChangeNotifier {
  static const Locale kSpanishLocale = Locale('es', 'ES');
  static const Locale kEnglishLocale = Locale('en', 'US');

  static const int kLanguageSpanish = 1;
  static const int kLanguageEnglish = 2;
}
