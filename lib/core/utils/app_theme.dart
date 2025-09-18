import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeLight = ThemeData(
    scaffoldBackgroundColor: AppColor.backgroundLightColor,
    textTheme: TextTheme(
      headlineSmall: AppStyle.medium16BlackLight,
      headlineMedium: AppStyle.bold20BlackLight,
    ),
  );

  static final ThemeData themeDark = ThemeData(
    scaffoldBackgroundColor: AppColor.backgroundDarkColor,
    textTheme: TextTheme(
      headlineSmall: AppStyle.medium16WhiteDark,
      headlineMedium: AppStyle.bold20WhiteDark,
    ),
  );

}
