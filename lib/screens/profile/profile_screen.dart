import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/screens/profile/widget/custom_drop_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/language_provider/language_provider.dart';
import '../../provider/theme_provider/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Provider.of<ThemeProvider>(context);
    var language = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        toolbarHeight: height * 0.23,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        ),
        title: Row(
          children: [
            Image.asset(
              AppAsset.routeImage,
              height: height * 0.25,
              width: width * 0.35,
            ),
            SizedBox(width: width * 0.07),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('John Safwat', style: AppStyle.bold24White),
                  Text(
                    'johnsafwat.route@gmail.com',
                    style: AppStyle.medium16White,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'language'.tr(),
              style:Theme.of(context).textTheme.headlineMedium
            ),
            SizedBox(height: height * 0.02),
            CustomDropMenu(
              initial: language.languageApp,
              onSelected: (value) {
                if (value != null) {
                  language.changeLanguage(value as Locale);
                  context.setLocale(value);
                }
              },
              menuList: [
                DropdownMenuEntry(value: Locale('en'), label: 'english'.tr()),
                DropdownMenuEntry(value: Locale('ar'), label: 'arabic'.tr()),
              ],
            ),
            SizedBox(height: height * 0.04),
            Text(
              'theme'.tr(),
              style:
              Theme.of(context).textTheme.headlineMedium
            ),
            SizedBox(height: height * 0.02),
            CustomDropMenu(
              key: ValueKey(context.locale), // يربط إعادة البناء بالـ Locale
              initial: theme.themeApp,
              onSelected: (value) {
                if (value != null) {
                  theme.changeTheme(value as ThemeMode);
                }
              },
              menuList: [
                DropdownMenuEntry(value: ThemeMode.light, label: 'light'.tr()),
                DropdownMenuEntry(value: ThemeMode.dark, label: 'dark'.tr()),
              ],
            ),

            Spacer(),
            ElevatedButton(
              onPressed: () {
                //todo logout button
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.redColor,
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                spacing: width * 0.03,
                children: [
                  SizedBox(width: width * 0.01),
                  Icon(
                    Icons.logout_rounded,
                    color: AppColor.whiteColor,
                    size: 30,
                  ),
                  Text('logout'.tr(), style: AppStyle.medium20White),
                ],
              ),
            ),
            SizedBox(height: height*0.013,),
          ],
        ),
      ),
    );
  }
}
