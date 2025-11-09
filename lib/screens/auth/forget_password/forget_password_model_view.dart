import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently/screens/auth/auth_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utils/app_route.dart';
import '../../../firebase/model/user_model.dart';

class ForgetPasswordModelView extends ChangeNotifier {
  //todo hold data - handle logic
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  late AuthInterface interface;
  void forgetPassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      //todo show loading
      interface.showLoading(message: 'loading'.tr());
      try {
        //todo check email is signup or not
        var users = await FirebaseFirestore.instance
            .collection(UserModel.collectionName)
            .where('email', isEqualTo: emailController.text)
            .get();

        if (users.docs.isEmpty) {
          //todo hide loading
          interface.hideLoading();
          //todo show message email not registered
          interface.showMessage(
            title: 'error'.tr(),
            message: 'email_not_registered'.tr(),
          );
          return;
        }
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text,
        );
        //todo hide loading
        interface.hideLoading();
        //todo show message successfully
        interface.showMessage(
          title: 'successfully'.tr(),
          message: 'password_reset_sent'.tr(),
          posActionClick: () {
            Navigator.pushReplacementNamed(context, AppRoute.loginRouteName);
          },
        );
      } on FirebaseAuthException catch (e) {
        //todo hide loading
        interface.hideLoading();
        String message;
        if (e.code == 'user-not-found') {
          message = 'user_not_found'.tr();
        } else if (e.code == 'invalid-email') {
          message = 'invalid_email'.tr();
        } else {
          message = e.message ?? 'something_went_wrong'.tr();
        }
        //todo show message error
        interface.showMessage(title: 'error'.tr(), message: message);
      }
    }
  }
}
