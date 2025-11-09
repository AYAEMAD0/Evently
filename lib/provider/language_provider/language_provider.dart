import 'package:evently/core/helper/shared_check_helper.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  late Locale languageApp;

  LanguageProvider(isEnglish){
    languageApp=isEnglish?Locale('en'):Locale('ar');
  }

  void changeLanguage(Locale newLocale)async {
    if (languageApp.languageCode == newLocale.languageCode) {
      return;
    } else {
      languageApp = newLocale;
    }
    SharedCheckHelper.setLanguage(isEnglishLanguage());
    notifyListeners();
  }

  bool isEnglishLanguage() {
    return languageApp.languageCode == 'en';
  }
}
