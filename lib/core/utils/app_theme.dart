import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData themeLight = ThemeData(
    scaffoldBackgroundColor: AppColor.backgroundLightColor,
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColor.primaryColor),
      scrolledUnderElevation: 0,elevation: 0
    ),
    canvasColor: AppColor.primaryColor,
    cardColor: AppColor.backgroundLightColor,
    colorScheme: ColorScheme.light(
      secondary: AppColor.backgroundLightColor,
      primary: AppColor.primaryColor,
      surface: AppColor.backgroundLightColor,
      outline:  AppColor.grayColor,
      outlineVariant: AppColor.grayColor
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
      foregroundColor: AppColor.backgroundLightColor,
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
      labelSmall: AppStyle.medium16Primary,
      labelMedium: AppStyle.bold18BlackLight,
      labelLarge: AppStyle.medium16Gray
    ),
  );

  static final ThemeData themeDark = ThemeData(
    scaffoldBackgroundColor: AppColor.backgroundDarkColor,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: AppColor.primaryColor),
        scrolledUnderElevation: 0,
        elevation: 0,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.backgroundDarkColor,
      foregroundColor: AppColor.whiteBeigeColor,
    ),
    canvasColor: AppColor.backgroundDarkColor,
    cardColor: AppColor.whiteBeigeColor,
    colorScheme: ColorScheme.dark(
      secondary: AppColor.primaryColor,
      primary: AppColor.whiteBeigeColor,
      surface: AppColor.backgroundDarkColor,
      outline:  AppColor.primaryColor,
      outlineVariant: AppColor.whiteBeigeColor

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
      labelSmall: AppStyle.medium16WhiteDark,
      labelMedium: AppStyle.bold18WhiteDark,
      labelLarge: AppStyle.medium16WhiteDark
    ),
  );
}
