import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/helper/validator_helper.dart';
import 'package:evently/core/utils/app_asset.dart';
import 'package:evently/core/utils/app_color.dart';
import 'package:evently/core/utils/app_style.dart';
import 'package:evently/core/widget/custom_button.dart';
import 'package:evently/core/widget/custom_text_field.dart';
import 'package:evently/screens/auth/auth_interface.dart';
import 'package:evently/screens/auth/forget_password/forget_password_model_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/custom_dialog.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    implements AuthInterface {
  ForgetPasswordModelView viewModel = ForgetPasswordModelView();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.interface = this;
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
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.040 * width,
              vertical: 0.03 * height,
            ),
            child: Form(
              key: viewModel.formKey,
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
                    SizedBox(height: 0.035 * height),
                    CustomButton(
                      onPressed: () {
                        //todo logic reset password
                        viewModel.forgetPassword(context);
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
      ),
    );
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
