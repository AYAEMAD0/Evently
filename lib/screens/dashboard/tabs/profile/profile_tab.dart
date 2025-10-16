import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_route.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_button.dart';
import 'package:evently/screens/dashboard/tabs/profile/widget/image_and_name_and_email.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/helper/shared_check_helper.dart';
import '../../../../provider/language_provider/language_provider.dart';
import '../../../../provider/theme_provider/theme_provider.dart';
import 'widget/custom_drop_menu.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var theme = Provider.of<ThemeProvider>(context);
    var language = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        leadingWidth: 0,
        toolbarHeight: height * 0.23,
        shape: RoundedRectangleBorder(
          borderRadius: language.isEnglishLanguage()
              ? const BorderRadius.only(
            bottomLeft: Radius.circular(80),
          )
              : const BorderRadius.only(
            bottomRight: Radius.circular(80),
          ),
        ),
        title: ImageAndNameAndEmail(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'language'.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: height * 0.02),
            //language
            CustomDropMenu(
              initial: language.languageApp,
              onSelected: (value) {
                if (value != null) {
                  language.changeLanguage(value as Locale);
                  context.setLocale(value);
                }
              },
              menuList: [
                DropdownMenuEntry(
                  value: Locale('en'),
                  label: 'english'.tr(),
                  style: builtStyleBtn(),
                ),
                DropdownMenuEntry(
                  value: Locale('ar'),
                  label: 'arabic'.tr(),
                  style: builtStyleBtn(),
                ),
              ],
            ),
            SizedBox(height: height * 0.04),
            Text(
              'theme'.tr(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: height * 0.02),
            //theme
            CustomDropMenu(
              key: ValueKey(context.locale), // يربط إعادة البناء بالـ Locale
              initial: theme.themeApp,
              onSelected: (value) {
                if (value != null) {
                  theme.changeTheme(value as ThemeMode);
                }
              },
              menuList: [
                DropdownMenuEntry(
                  value: ThemeMode.light,
                  label: 'light'.tr(),
                  style: builtStyleBtn(),
                ),
                DropdownMenuEntry(
                  value: ThemeMode.dark,
                  label: 'dark'.tr(),
                  style: builtStyleBtn(),
                ),
              ],
            ),
            Spacer(),
            CustomButton(
              onPressed: () async{
                //todo logout button
                await SharedCheckHelper.setLogin(false);
                await Future.delayed(Duration(milliseconds: 300));
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.loginRouteName, (route) => false,);
              },
              backgroundColor: AppColor.redColor,
              isIcon: true,
              iconWidget: Row(children: [
                Icon(
                  Icons.logout_rounded,
                  color: AppColor.whiteColor,
                  size: 30,
                ),
                SizedBox(width: width*0.02,),
                Text('logout'.tr(), style: AppStyle.medium20White,)
              ],),

            ),
            SizedBox(height: height * 0.023),
          ],
        ),
      ),
    );
  }

  ButtonStyle builtStyleBtn() {
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.all(AppColor.blackColor),
    );
  }
}
