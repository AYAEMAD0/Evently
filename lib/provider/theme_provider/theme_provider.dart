import 'package:evently/core/helper/shared_check_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode themeApp;

  ThemeProvider(bool isDark) {
    themeApp = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (themeApp == newTheme) {
      return;
    } else {
      themeApp = newTheme;
    }
    SharedCheckHelper.setTheme(isDark());
    notifyListeners();
  }

  bool isDark() {
    return themeApp == ThemeMode.dark;
  }
}