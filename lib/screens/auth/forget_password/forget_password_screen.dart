import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/helper/validator_helper.dart';
import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/utils/app_route.dart';
import '../../core/utils/custom_dialog.dart';
import '../../firebase/model/user_model.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("forget_password".tr(), style: AppStyle.medium20Primary),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.040 * width,
            vertical: 0.03 * height,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    AppAsset.forgetPasswordImage,
                    height: 0.39 * height,
                  ),
                  SizedBox(height: 0.035 * height),
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
                  SizedBox(height: 0.035 * height),
                  CustomButton(
                    onPressed: () {
                      //todo logic reset password
                      resetPassword(emailController.text);
                    },
                    backgroundColor: AppColor.primaryColor,
                    text: 'reset_password'.tr(),
                    styleText: AppStyle.medium20White,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword(String email) async {
    if (formKey.currentState!.validate()) {
      //todo show loading
      CustomDialog.showLoading(
        context: context,
        background: Theme.of(context).scaffoldBackgroundColor,
        text: 'loading'.tr(),
        style: Theme.of(context).textTheme.headlineSmall,
      );

      try {
        //todo check email is signup or not
        var users = await FirebaseFirestore.instance
            .collection(UserModel.collectionName)
            .where('email', isEqualTo: emailController.text)
            .get();

        if (users.docs.isEmpty) {
          //todo hide loading
          CustomDialog.hideLoading(context: context);
          //todo show message email not registered
          CustomDialog.showMessage(
            context: context,
            background: Theme.of(context).scaffoldBackgroundColor,
            styleMessage: Theme.of(context).textTheme.headlineSmall,
            title: 'error'.tr(),
            message: 'email_not_registered'.tr(),
            posActionName: 'ok'.tr(),
          );
          return;
        }
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
        //todo hide loading
        CustomDialog.hideLoading(context: context);
        //todo show message successfully
        CustomDialog.showMessage(
          context: context,
          background: Theme.of(context).scaffoldBackgroundColor,
          styleMessage: Theme.of(context).textTheme.headlineSmall,
          message: 'password_reset_sent'.tr(),
          title: 'successfully'.tr(),
          posActionName: 'ok'.tr(),
          posActionClick: () {
            Navigator.pushReplacementNamed(context, AppRoute.loginRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        //todo hide loading
        CustomDialog.hideLoading(context: context);
        String message;
        if (e.code == 'user-not-found') {
          message = 'user_not_found'.tr();
        } else if (e.code == 'invalid-email') {
          message = 'invalid_email'.tr();
        } else {
          message = e.message ?? 'something_went_wrong'.tr();
        }
        //todo show message error
        CustomDialog.showMessage(
          context: context,
          background: Theme.of(context).scaffoldBackgroundColor,
          styleMessage: Theme.of(context).textTheme.headlineSmall,
          title: 'error'.tr(),
          message: message,
          posActionName: 'ok'.tr(),
        );
      }
    }
  }
}
