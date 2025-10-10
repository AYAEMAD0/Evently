import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/helper/validator_helper.dart';
import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_route.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/core/widget/custom_toggle_language.dart';
import 'package:evently/screens/auth/widget/already_and_donot_have_account.dart';
import 'package:evently/screens/auth/widget/built_or_way_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/utils/custom_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print('---------------------------------------------');
    print(context.locale);
    print('---------------------------------------------');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.040 * width,
              vertical: height * 0.02,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppAsset.logoAuthImage, height: 0.19 * height),
                  SizedBox(height: 0.02 * height),
                  CustomTextField(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    hint: "email".tr(),
                    controller: emailController,
                    validator: (text) => ValidatorHelper.validateEmail(text),
                    hintStyle: Theme.of(context).textTheme.labelLarge!,
                    borderColor: Theme.of(context).colorScheme.outline,
                    fillColor: AppColor.transparentColor,
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Theme.of(
                      context,
                    ).colorScheme.outlineVariant,
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextField(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    hint: "password".tr(),
                    controller: passwordController,
                    validator: (text) => ValidatorHelper.validatePassword(text),
                    hintStyle: Theme.of(context).textTheme.labelLarge!,
                    borderColor: Theme.of(context).colorScheme.outline,
                    fillColor: AppColor.transparentColor,
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Theme.of(
                      context,
                    ).colorScheme.outlineVariant,
                    obscure: showPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        //todo show password
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        showPassword
                            ? Icons.visibility_off_sharp
                            : Icons.visibility,
                      ),
                    ),
                    suffixIconColor: Theme.of(
                      context,
                    ).colorScheme.outlineVariant,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        //todo forget password
                        Navigator.pushNamed(
                          context,
                          AppRoute.forgetPasswordRouteName,
                        );
                      },
                      child: Text(
                        "forget".tr(),
                        style: AppStyle.bold16Primary.copyWith(
                          decorationColor: AppColor.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.024 * height),
                  CustomButton(
                    onPressed: () async {
                      //todo logic login
                      if (formKey.currentState!.validate()) {
                        //todo show loading
                        CustomDialog.showLoading(
                          context: context,
                          background: Theme.of(context).scaffoldBackgroundColor,
                          text: 'loading'.tr(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        );
                        try {
                          var credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                          var user = credential.user;
                          await user?.reload();
                          if (user != null && user.emailVerified) {
                            //todo hide loading
                            CustomDialog.hideLoading(context: context);
                            //todo show message successfully
                            CustomDialog.showMessage(
                              context: context,
                              background: Theme.of(
                                context,
                              ).scaffoldBackgroundColor,
                              styleMessage: Theme.of(
                                context,
                              ).textTheme.headlineSmall,
                              message: 'login_successfully'.tr(),
                              title: 'successfully'.tr(),
                              posActionName: 'ok'.tr(),
                              posActionClick: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoute.dashBoardRouteName,
                                );
                              },
                            );
                          }else {
                            await user?.sendEmailVerification();
                            //todo hide loading
                            CustomDialog.hideLoading(context: context);
                            //todo show error Verification
                            CustomDialog.showMessage(
                              context: context,
                              background: Theme.of(context).scaffoldBackgroundColor,
                              styleMessage: Theme.of(context).textTheme.headlineSmall,
                              title: 'email_not_verified'.tr(),
                              message:
                              '${'email_not_verified'.tr()} ${emailController.text}. ${"verify_logging".tr()}',
                              posActionName: 'ok'.tr(),
                            );
                            await FirebaseAuth.instance.signOut();
                          }
                        } catch (e) {
                          //todo hide loading
                          CustomDialog.hideLoading(context: context);
                          //todo show message error
                          CustomDialog.showMessage(
                            context: context,
                            background: Theme.of(
                              context,
                            ).scaffoldBackgroundColor,
                            styleMessage: Theme.of(
                              context,
                            ).textTheme.headlineSmall,
                            title: 'error'.tr(),
                            message: e.toString(),
                            posActionName: 'ok'.tr(),
                          );
                        }
                      }
                    },
                    backgroundColor: AppColor.primaryColor,
                    text: 'login'.tr(),
                    styleText: AppStyle.medium20White,
                  ),
                  SizedBox(height: 0.024 * height),
                  AlreadyAndDonotHaveAccount(
                    text: 'do_not_have_account'.tr(),
                    textButton: "create_account".tr(),
                    onPressed: () {
                      //todo nav into signup
                      Navigator.pushNamed(context, AppRoute.signupRouteName);
                    },
                  ),
                  SizedBox(height: 0.02 * height),
                  BuiltOrWayLogin(),
                  SizedBox(height: 0.03 * height),
                  CustomButton(
                    onPressed: (){
                      //todo login with google
                    },
                    backgroundColor: AppColor.transparentColor,
                    borderColor: AppColor.primaryColor,
                    paddingHeight: height * 0.019,
                    isIcon: true,
                    iconWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppAsset.googleImage),
                        SizedBox(width: width * 0.02),
                        Text(
                          'login_with_google'.tr(),
                          style: AppStyle.medium20Primary,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.03 * height),
                  Align(
                    alignment: Alignment.center,
                    child: CustomToggleLanguage(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
