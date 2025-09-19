import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeLight = ThemeData(
    scaffoldBackgroundColor: AppColor.backgroundLightColor,
    canvasColor: AppColor.primaryColor,
    cardColor: AppColor.backgroundLightColor,
    colorScheme: ColorScheme.light(
      secondary: AppColor.backgroundLightColor,
        primary: AppColor.primaryColor
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.backgroundLightColor
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.primaryColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.backgroundLightColor,
      unselectedItemColor: AppColor.backgroundLightColor,
    ),
    textTheme: TextTheme(
      headlineSmall: AppStyle.medium16BlackLight,
      headlineMedium: AppStyle.bold20BlackLight,
      headlineLarge: AppStyle.bold24WhiteLight,
      bodySmall: AppStyle.regular16WhiteLight,
      bodyMedium: AppStyle.bold18PrimaryLight,
      bodyLarge: AppStyle.medium16WhiteLight,
      labelSmall: AppStyle.medium16Primary
    ),
  );

  static final ThemeData themeDark = ThemeData(
    scaffoldBackgroundColor: AppColor.backgroundDarkColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColor.backgroundDarkColor,
      foregroundColor: AppColor.whiteBeigeColor,
    ),
    canvasColor: AppColor.backgroundDarkColor,
    cardColor: AppColor.whiteBeigeColor,
    colorScheme: ColorScheme.dark(
      secondary: AppColor.primaryColor,
      primary: AppColor.whiteBeigeColor
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.backgroundDarkColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.whiteBeigeColor,
      unselectedItemColor: AppColor.whiteBeigeColor,
    ),
    textTheme: TextTheme(
      headlineSmall: AppStyle.medium16WhiteDark,
      headlineMedium: AppStyle.bold20WhiteDark,
      headlineLarge: AppStyle.bold24WhiteDark,
      bodySmall: AppStyle.regular16WhiteDark,
      bodyMedium: AppStyle.bold18BlackDark,
        bodyLarge: AppStyle.medium16WhiteDark,
        labelSmall: AppStyle.medium16WhiteDark
    ),
  );
}
