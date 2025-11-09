import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/helper/validator_helper.dart';
import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_route.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/utils/custom_dialog.dart';
import 'package:evently/core/widget/custom_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/core/widget/custom_toggle_language.dart';
import 'package:evently/screens/auth/widget/already_and_donot_have_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../firebase/model/user_model.dart';
import '../../provider/user_provider/user_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  bool showPassword = false;
  bool showRePassword = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("register".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.040 * width,
              vertical: 0.02 * height,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppAsset.logoAuthImage, height: 0.19 * height),
                  SizedBox(height: 0.03 * height),
                  CustomTextField(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    hint: "name".tr(),
                    controller: nameController,
                    validator: (text) => ValidatorHelper.validateName(text),
                    hintStyle: Theme.of(context).textTheme.labelLarge!,
                    borderColor: Theme.of(context).colorScheme.outline,
                    fillColor: AppColor.transparentColor,
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Theme.of(
                      context,
                    ).colorScheme.outlineVariant,
                  ),
                  SizedBox(height: 0.03 * height),
                  CustomTextField(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    keyboard: TextInputType.emailAddress,
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
                    keyboard: TextInputType.visiblePassword,
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
                  SizedBox(height: 0.03 * height),
                  CustomTextField(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    keyboard: TextInputType.visiblePassword,
                    hint: "re_password".tr(),
                    controller: rePasswordController,
                    validator: (text) =>
                        ValidatorHelper.validateConfirmPassword(
                          text,
                          passwordController.text,
                        ),
                    hintStyle: Theme.of(context).textTheme.labelLarge!,
                    borderColor: Theme.of(context).colorScheme.outline,
                    fillColor: AppColor.transparentColor,
                    prefixIcon: Icon(Icons.lock),
                    prefixIconColor: Theme.of(
                      context,
                    ).colorScheme.outlineVariant,
                    obscure: showRePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        //todo show password
                        setState(() {
                          showRePassword = !showRePassword;
                        });
                      },
                      icon: Icon(
                        showRePassword
                            ? Icons.visibility_off_sharp
                            : Icons.visibility,
                      ),
                    ),
                    suffixIconColor: Theme.of(
                      context,
                    ).colorScheme.outlineVariant,
                  ),
                  SizedBox(height: 0.024 * height),
                  CustomButton(
                    onPressed: () async {
                      //todo logic signup
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
                              .createUserWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                          var user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            await user.updateDisplayName(
                              nameController.text.trim(),
                            );
                            await user.reload();
                            user = FirebaseAuth.instance.currentUser;
                            await user!.sendEmailVerification();
                            var userModel = UserModel(
                              id: user.uid,
                              name: user.displayName ?? "",
                              email: user.email ?? "",
                            );

                            userProvider.changeCurrentUser(userModel);

                            print('---------------------------------------');
                            print('Name: ${user.displayName}');
                            print('UID: ${user.uid}');
                            print('Email: ${user.email}');
                            print('---------------------------------------');


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
                            message:
                                '${'verification_email_sent'.tr()} ${emailController.text} ${"check_inbox".tr()}',
                            title: 'successfully'.tr(),
                            posActionName: 'ok'.tr(),
                            posActionClick: () {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoute.loginRouteName,
                              );
                            },
                          );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
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
                              message: "weak_password".tr(),
                              posActionName: 'Ok',
                            );
                          } else if (e.code == 'email-already-in-use') {
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
                              message: "email_already_exists".tr(),
                              posActionName: 'ok'.tr(),
                            );
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
                    text: 'create_account'.tr(),
                    styleText: AppStyle.medium20White,
                  ),
                  SizedBox(height: 0.02 * height),
                  AlreadyAndDonotHaveAccount(
                    text: 'already_have_account'.tr(),
                    textButton: "login".tr(),
                    onPressed: () {
                      //todo nav into login
                      Navigator.pushNamed(context, AppRoute.loginRouteName);
                    },
                  ),
                  SizedBox(height: 0.02 * height),
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
