import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_route.dart';
import 'package:evently/core/utils/app_theme.dart';
import 'package:evently/provider/theme_provider/theme_provider.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:evently/screens/onboarding/onboarding_screen.dart';
import 'package:evently/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/language_provider/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        startLocale: Locale('en'),
        fallbackLocale: Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var language = Provider.of<LanguageProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        AppRoute.onBoardingRouteName: (context) => OnboardingScreen(),
        AppRoute.homeRouteName: (context) => HomeScreen(),
        AppRoute.profileRouteName:(context)=>ProfileScreen()
      },
      initialRoute: AppRoute.onBoardingRouteName,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: language.languageApp,

      theme: AppTheme.themeLight,
      darkTheme: AppTheme.themeDark,
      themeMode: theme.themeApp,
    );
  }
}
