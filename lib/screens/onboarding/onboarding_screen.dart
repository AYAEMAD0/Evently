import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_theme.dart';
import 'package:evently/provider/language_provider/language_provider.dart';
import 'package:evently/provider/theme_provider/theme_provider.dart';
import 'package:evently/screens/onboarding/onboarding_other.dart';
import 'package:evently/screens/onboarding/widget/custom_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_asset.dart';
import '../../core/utils/app_color.dart';
import '../../core/utils/app_style.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int themeValue = 0;
  int languageValue = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Provider.of<ThemeProvider>(context);
    var language = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.transparentColor,
        title: Image.asset(
          AppAsset.logoImage,
          height: height * 0.06,
          width: width * 0.40,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppAsset.onboardingImage1),
            Text(
              "title1".tr(),
              style: AppStyle.bold20PrimaryLight,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: height * 0.02),
            Text(
              "desc1".tr(),
              style: theme.isDark()
                  ? AppTheme.themeDark.textTheme.headlineSmall
                  : AppTheme.themeLight.textTheme.headlineSmall,
              textAlign: TextAlign.start,
              maxLines: 10,
            ),
            SizedBox(height: height * 0.02),
            // language
            CustomToggleSwitch(
              current: languageValue,
              text: 'language'.tr(),
              onChanged: (value) async {
                return setState(() {
                  languageValue = value;
                  // english 0   arabic 1
                  if (value == 0) {
                    context.setLocale(const Locale('en'));
                    language.changeLanguage(const Locale('en'));
                  } else {
                    context.setLocale(const Locale('ar'));
                    language.changeLanguage(const Locale('ar'));
                  }
                });
              },
              customIconBuilder: (context, local, global) {
                if (local.value == 0) {
                  return SvgPicture.asset(
                    AppAsset.englishImage,
                    width: 25,
                    height: 25,
                  );
                } else {
                  return SvgPicture.asset(
                    AppAsset.arabicImage,
                    width: 25,
                    height: 25,
                  );
                }
              },
            ),

            SizedBox(height: height * 0.022),
            // theme
            CustomToggleSwitch(
                current: themeValue,
                text: 'theme'.tr(),
                onChanged: (value) async{
                  return setState(() {
                    themeValue = value;
                    // Light 0    Dark 1
                    if (value == 0) {
                      theme.changeTheme(ThemeMode.light);
                    } else {
                      theme.changeTheme(ThemeMode.dark);
                    }
                  });
                },
              customIconBuilder: (context, local, global) {
                if (local.value == 0) {
                  return SvgPicture.asset(
                    AppAsset.sunLightImage,
                    color: !(theme.isDark())
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                    width: 18,
                    height: 18,
                  );
                } else {
                  return SvgPicture.asset(
                    AppAsset.moonImage,
                    color: theme.isDark()
                        ? AppColor.whiteColor
                        : AppColor.primaryColor,
                    width: 20,
                    height: 20,
                  );
                }
              },),

            Spacer(),
            ElevatedButton(
              onPressed: () {
                //todo nav to onboarding other
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnboardingOther()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                foregroundColor: AppColor.whiteColor,
                padding: EdgeInsets.all(5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('let_start'.tr(), style: AppStyle.medium20White),
            ),
            SizedBox(height: height * 0.01),
          ],
        ),
      ),
    );
  }
}
