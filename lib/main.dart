import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_route.dart';
import 'package:evently/core/utils/app_theme.dart';
import 'package:evently/provider/theme_provider/theme_provider.dart';
import 'package:evently/screens/auth/forget_password_screen.dart';
import 'package:evently/screens/auth/login_screen.dart';
import 'package:evently/screens/auth/signup_screen.dart';
import 'package:evently/screens/dashboard/dashboard_screen.dart';
import 'package:evently/screens/dashboard/tabs/add_event/add_event_tab.dart';
import 'package:evently/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/language_provider/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isDark = prefs.getBool('isDark') ?? false;
  final bool isEnglish= prefs.getBool('isEnglish') ?? true;
  final Locale startedLocale = isEnglish ? const Locale('en') : const Locale('ar');

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      startLocale: startedLocale,
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ThemeProvider(isDark),
          ),
          ChangeNotifierProvider(
            create: (_) => LanguageProvider(isEnglish),
          ),
        ],
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
        AppRoute.dashBoardRouteName: (context) => DashboardScreen(),
        AppRoute.loginRouteName: (context) => LoginScreen(),
        AppRoute.signupRouteName: (context) => SignupScreen(),
        AppRoute.forgetPasswordRouteName: (context) => ForgetPasswordScreen(),
        AppRoute.addEventRouteName: (context) => AddEventTab(),
      },
      initialRoute: AppRoute.dashBoardRouteName,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.themeLight,
      darkTheme: AppTheme.themeDark,
      themeMode: theme.themeApp,
    );
  }
}
