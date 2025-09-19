import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_route.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import '../../core/utils/app_theme.dart';
import '../../provider/language_provider/language_provider.dart';
import '../../provider/theme_provider/theme_provider.dart';

class OnboardingOther extends StatefulWidget {
  const OnboardingOther({super.key});

  @override
  State<OnboardingOther> createState() => _OnboardingOtherState();
}

class _OnboardingOtherState extends State<OnboardingOther> {
  final model = OnboardingModel.onboardingList;
  late var theme;
  late var language;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    theme = Provider.of<ThemeProvider>(context);
    language = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAsset.logoImage,
          height: height * 0.06,
          width: width * 0.40,
        ),
        centerTitle: true,
        backgroundColor: AppColor.transparentColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: width * 0.01,
          left: width * 0.01,
          top: height * 0.03,
        ),
        child: IntroductionScreen(
          pages: List.generate(model.length, (index) {
            return builtPageView(
              model[index].image,
              model[index].title.tr(),
              model[index].desc.tr(),
            );
          }),
          showBackButton: true,
          back: builtBackBtn(
            Icons.arrow_back,
            language.isEnglishLanguage()
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
          ),
          next: builtBackBtn(
            Icons.arrow_forward,
            language.isEnglishLanguage()
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
          ),
          done: builtBackBtn(
            Icons.arrow_forward,
            language.isEnglishLanguage()
                ? Alignment.bottomRight
                : Alignment.bottomLeft,
          ),
          onDone: () {
            Navigator.pushReplacementNamed(context, AppRoute.dashBoardRouteName);
          },
          showDoneButton: true,
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            color: theme.isDark()
                ? AppColor.whiteBeigeColor
                : AppColor.blackColor,
            activeSize: const Size(22.0, 10.0),
            activeColor: AppColor.primaryColor,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
          ),
        ),
      ),
    );
  }

  PageViewModel builtPageView(String image, String title, String desc) {
    return PageViewModel(
      image: Image.asset(image, fit: BoxFit.contain),
      titleWidget: Align(
        alignment: language.isEnglishLanguage()
            ? Alignment.topLeft
            : Alignment.topRight,
        child: Text(title, style: AppStyle.bold20PrimaryLight),
      ),
      bodyWidget: Text(
        desc,
        style: theme.isDark()
            ? AppTheme.themeDark.textTheme.headlineSmall
            : AppTheme.themeLight.textTheme.headlineSmall,
        textAlign: language.languageApp.languageCode == 'en'
            ? TextAlign.left
            : TextAlign.right,
        maxLines: 15,
      ),
    );
  }

  Widget builtBackBtn(icon, align) {
    return Align(alignment: align, child: builtCircleBtn(icon));
  }

  Widget builtCircleBtn(icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(icon, color: AppColor.primaryColor),
    );
  }
}
