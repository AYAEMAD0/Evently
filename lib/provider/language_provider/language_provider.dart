import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale languageApp = const Locale('en');

  void changeLanguage(Locale newLocale) {
    if (languageApp.languageCode == newLocale.languageCode) {
      return;
    } else {
      languageApp = newLocale;
    }
    notifyListeners();
  }

  bool isEnglishLanguage() {
    return languageApp.languageCode == 'en';
  }
}
