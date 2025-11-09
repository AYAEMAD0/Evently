import 'package:easy_localization/easy_localization.dart';
import 'package:evently/provider/user_provider/user_provider.dart';
import 'package:evently/screens/auth/auth_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/utils/app_route.dart';
import '../../../firebase/model/user_model.dart';

class LoginModelView extends ChangeNotifier {
  //todo hold data - handle logic
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool showPassword = false;


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  late AuthInterface interface;
  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      //todo show loading
      interface.showLoading(message: 'loading'.tr());
      try {
        var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = credential.user;
        await user?.reload();
        if (user != null && user.emailVerified) {
          //todo hide loading
          interface.hideLoading();
          //todo show message successfully
          interface.showMessage(
            message: 'login_successfully'.tr(),
            title: 'successfully'.tr(),
            posActionClick: () {
              return Navigator.pushReplacementNamed(
                context,
                AppRoute.dashBoardRouteName,
              );
            },
          );
        } else {
          await user?.sendEmailVerification();
          //todo hide loading
          interface.hideLoading();
          //todo show error Verification
          interface.showMessage(
            title: 'email_not_verified'.tr(),
            message:
                '${'email_not_verified'.tr()} ${emailController.text}. ${"verify_logging".tr()}',
          );
          await FirebaseAuth.instance.signOut();
        }
      } catch (e) {
        //todo hide loading
        interface.hideLoading();
        //todo show message error
        interface.showMessage(title: 'error'.tr(), message: e.toString());
      }
    }
  }
  void loginWithGoogle(BuildContext context, UserProvider userProvider) async {
    //todo show loading
    interface.showLoading(message: 'loading'.tr());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        //todo hide loading
        interface.hideLoading();
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.idToken,
        idToken: googleAuth.idToken,
      );
      FirebaseAuth.instance.signInWithCredential(credential);
      var user = UserModel(
        id: googleUser.id,
        name: googleUser.displayName!,
        email: googleUser.email,
      );
      userProvider.changeCurrentUser(user);
      debugPrint('---------------------------------------');
      debugPrint('Name: ${googleUser.displayName ?? ""}');
      debugPrint('UID: ${googleUser.id}');
      debugPrint('Email: ${googleUser.email}');
      debugPrint('---------------------------------------');
      //todo hide loading
      interface.hideLoading();
      //todo show message successfully
      interface.showMessage(
        title: 'successfully'.tr(),
        message: 'login_successfully'.tr(),
        posActionClick: () {
          Navigator.pushReplacementNamed(context, AppRoute.dashBoardRouteName);
        },
      );
    } on Exception catch (e) {
      //todo hide loading
      interface.hideLoading();
      //todo show message error
      interface.showMessage(title: 'error'.tr(), message: e.toString());
    }
  }
  void togglePassword(){
      showPassword = !showPassword;
      notifyListeners();
  }
}
