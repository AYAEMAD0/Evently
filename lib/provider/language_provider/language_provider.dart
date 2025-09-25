import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnglish', isEnglishLanguage());
    notifyListeners();
  }

  bool isEnglishLanguage() {
    return languageApp.languageCode == 'en';
  }
}
