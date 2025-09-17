import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  Locale languageApp = const Locale('en');

  void changeLanguage(newLanguage){
    if(languageApp==newLanguage){
      return;
    }else{
      languageApp=newLanguage;
    }
    notifyListeners();
  }

  bool isEnglishLanguage(){
    return languageApp.languageCode == 'en';
  }
}