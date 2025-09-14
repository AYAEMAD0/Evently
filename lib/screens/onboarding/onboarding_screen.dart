import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_route.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AppAsset.logoImage,
          height: height * 0.05,
          width: width * 0.40,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
        child: IntroductionScreen(
          pages: [
            builtPageView(
                AppAsset.onboardingImage1,
                'Personalize Your Experience',
                "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                footerWidget: builtFooter()
            ),
            builtPageView(
              AppAsset.onboardingImage2,
              'Find Events That Inspire You',
              "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
            ),
            builtPageView(
              AppAsset.onboardingImage3,
              'Effortless Event Planning',
              "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
            ),
            builtPageView(
              AppAsset.onboardingImage4,
              'Connect with Friends & Share Moments',
              "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
            ),
          ],
          showBackButton: true,
          back: builtCircleBtn(Icons.arrow_back),
          next: builtCircleBtn(Icons.arrow_forward),
          done: builtCircleBtn(Icons.arrow_forward),
          onDone: () {
            Navigator.pushReplacementNamed(context, AppRoute.homeRouteName);
          },
          showDoneButton: true,
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            activeColor: AppColor.primaryColor,
            color: AppColor.blackColor,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
  }

  PageViewModel builtPageView(String image, String title, String desc,
      {Widget? footerWidget}) {
    return PageViewModel(
      image: Image.asset(image),
      titleWidget: Text(title, style: AppStyle.bold20Primary),
      footer: footerWidget,
      bodyWidget: Text(
      desc,
      style: AppStyle.bold16Black,
      textAlign: TextAlign.start,
      maxLines: 6,
    ),);
  }

  Widget builtCircleBtn(icon) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: AppColor.primaryColor),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Icon(icon, color: AppColor.primaryColor),
    );
  }

  Widget builtFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        // language
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Language', style: AppStyle.bold20Primary),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColor.primaryColor, width: 2),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 21,
                    width: 21,
                    child: SvgPicture.asset(AppAsset.englishImage),
                  ),
                  const SizedBox(width: 4), // بدل spacing
                  SizedBox(
                    height: 21,
                    width: 25,
                    child: SvgPicture.asset(AppAsset.arabicImage),
                  ),
                ],
              ),
            ),
          ],
        ),
        // theme
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Theme', style: AppStyle.bold20Primary),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColor.primaryColor, width: 2),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppAsset.sunDarkImage),
                  const SizedBox(width: 4), // بدل spacing
                  SvgPicture.asset(AppAsset.moonImage),
                ],
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            //todo onboarding one button
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryColor,
            foregroundColor: AppColor.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Let’s Start'),
        ),
      ],
    );
  }

}
