import 'package:easy_localization/easy_localization.dart';
import 'package:evently/provider/user_provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_route.dart';
import '../../../firebase/model/user_model.dart';
import '../auth_interface.dart';

class SignupModelView extends ChangeNotifier {
  //todo hold data - handle logic
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool showRePassword = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  late AuthInterface interface;
  void signup(BuildContext context, UserProvider userProvider) async {
    if (formKey.currentState!.validate()) {
      //todo show loading
      interface.showLoading(message: 'loading'.tr());
      try {
        var credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
        var user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          await user.updateDisplayName(nameController.text.trim());
          await user.reload();
          user = FirebaseAuth.instance.currentUser;
          await user!.sendEmailVerification();
          var userModel = UserModel(
            id: user.uid,
            name: user.displayName ?? "",
            email: user.email ?? "",
          );

          userProvider.changeCurrentUser(userModel);
          debugPrint('-----------------------------------');
          debugPrint('Name: ${user.displayName}');
          debugPrint('UID: ${user.uid}');
          debugPrint('Email: ${user.email}');
          debugPrint('-------------------------------------');

          //todo hide loading
          interface.hideLoading();
          //todo show message successfully
          interface.showMessage(
            title: 'successfully'.tr(),
            message:
                '${'verification_email_sent'.tr()} ${emailController.text} ${"check_inbox".tr()}',
            posActionClick: () {
              Navigator.pushReplacementNamed(context, AppRoute.loginRouteName);
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          //todo hide loading
          interface.hideLoading();
          //todo show message error
          interface.showMessage(
            title: 'error'.tr(),
            message: "weak_password".tr(),
          );
        } else if (e.code == 'email-already-in-use') {
          //todo hide loading
          interface.hideLoading();
          //todo show message error
          interface.showMessage(
            title: 'error'.tr(),
            message: "email_already_exists".tr(),
          );
        }
      } catch (e) {
        //todo hide loading
        interface.hideLoading();
        //todo show message error
        interface.showMessage(title: 'error'.tr(), message: e.toString());
      }
    }
  }

  void togglePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void toggleRePassword() {
    showRePassword = !showRePassword;
    notifyListeners();
  }
}
