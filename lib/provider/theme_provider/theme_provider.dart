import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode themeApp=ThemeMode.light;

  void changeTheme(ThemeMode newTheme){
    if(themeApp==newTheme){
      return;
    }else{
      themeApp=newTheme;
    }
    notifyListeners();
  }

  bool isDark(){
    return themeApp==ThemeMode.dark;
  }

}