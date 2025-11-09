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
import 'package:evently/screens/auth/auth_interface.dart';
import 'package:evently/screens/auth/signup/signup_model_view.dart';
import 'package:evently/screens/auth/widget/already_and_donot_have_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase/model/user_model.dart';
import '../../../provider/user_provider/user_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> implements AuthInterface {
  SignupModelView viewModel = SignupModelView();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.interface=this;
  }

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
      body:
      ChangeNotifierProvider(create: (context) => viewModel,
      child:
      SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.040 * width,
              vertical: 0.02 * height,
            ),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(AppAsset.logoAuthImage, height: 0.19 * height),
                  SizedBox(height: 0.03 * height),
                  CustomTextField(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    hint: "name".tr(),
                    controller: viewModel.nameController,
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
                    controller: viewModel.emailController,
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
                  Consumer<SignupModelView>(
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          CustomTextField(
                            textStyle: Theme.of(context).textTheme.labelLarge!,
                            keyboard: TextInputType.visiblePassword,
                            hint: "password".tr(),
                            controller: viewModel.passwordController,
                            validator: (text) =>
                                ValidatorHelper.validatePassword(text),
                            hintStyle: Theme.of(context).textTheme.labelLarge!,
                            borderColor: Theme.of(context).colorScheme.outline,
                            fillColor: AppColor.transparentColor,
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: Theme.of(
                              context,
                            ).colorScheme.outlineVariant,
                            obscure: value.showPassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                //todo show password
                                value.togglePassword();
                              },
                              icon: Icon(
                                value.showPassword
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
                            controller: viewModel.rePasswordController,
                            validator: (text) =>
                                ValidatorHelper.validateConfirmPassword(
                                  text,
                                  viewModel.passwordController.text,
                                ),
                            hintStyle: Theme.of(context).textTheme.labelLarge!,
                            borderColor: Theme.of(context).colorScheme.outline,
                            fillColor: AppColor.transparentColor,
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: Theme.of(
                              context,
                            ).colorScheme.outlineVariant,
                            obscure: value.showRePassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                //todo show RePassword
                                value.toggleRePassword();
                              },
                              icon: Icon(
                                value.showRePassword
                                    ? Icons.visibility_off_sharp
                                    : Icons.visibility,
                              ),
                            ),
                            suffixIconColor: Theme.of(
                              context,
                            ).colorScheme.outlineVariant,
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 0.024 * height),
                  CustomButton(
                    onPressed: () async {
                      //todo logic signup
                      viewModel.signup(context, userProvider);
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
    ));
  }

  @override
  void hideLoading() {
    // TODO: implement hideLoading
    CustomDialog.hideLoading(context: context);
  }

  @override
  void showLoading({String? message}) {
    // TODO: implement showLoading
    CustomDialog.showLoading(
      context: context,
      background: Theme.of(context).scaffoldBackgroundColor,
      text: message!,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  @override
  void showMessage({String? message, String? title, Function? posActionClick}) {
    // TODO: implement showMessage
    CustomDialog.showMessage(
      context: context,
      background: Theme.of(context).scaffoldBackgroundColor,
      styleMessage: Theme.of(context).textTheme.headlineSmall,
      title: title,
      message: message!,
      posActionName: 'ok'.tr(),
      posActionClick: posActionClick,
    );
  }
}
