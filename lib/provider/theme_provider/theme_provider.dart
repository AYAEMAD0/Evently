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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark());
    notifyListeners();
  }

  bool isDark() {
    return themeApp == ThemeMode.dark;
  }
}