import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/helper/validator_helper.dart';
import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:flutter/material.dart';

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
                  Image.asset(AppAsset.forgetPasswordImage, height: 0.39 * height),
                  SizedBox(height: 0.035 * height),
                  CustomTextField(
                    textStyle: Theme.of(context).textTheme.labelLarge!,
                    keyboard: TextInputType.emailAddress,
                    hint: "email".tr(),
                    controller: emailController,
                    validator: (text)=>ValidatorHelper.validateEmail(text),
                    hintStyle: Theme.of(context).textTheme.labelLarge!,
                    borderColor: Theme.of(context).colorScheme.outline,
                    fillColor: AppColor.transparentColor,
                    prefixIcon: Icon(Icons.email),
                    prefixIconColor: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  SizedBox(height: 0.035 * height),
                  CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                      //todo logic reset password
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
}
