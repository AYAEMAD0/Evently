import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  String languageApp='en';

  void changeLanguage(newLanguage){
    if(languageApp==newLanguage){
      return;
    }else{
      languageApp=newLanguage;
    }
    notifyListeners();
  }

  bool isEnglishLanguage(){
    return languageApp=='en' ;
  }
}