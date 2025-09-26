import 'package:easy_localization/easy_localization.dart';

class ValidatorHelper{
  static String? validateName(String? text){
    if (text == null || text.trim().isEmpty) {
      return "name_required".tr();
    }
    if (text.length < 3) {
      return "name_min_length".tr();
    }
    return null;
  }

  static String? validateEmail(String? text){
    if (text == null || text.trim().isEmpty) {
      return "email_required".tr();
    }
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(text);
    if (!emailValid) {
      return "email_invalid".tr();
    }
    return null;
  }
  static String? validatePassword(String? text){
    if(text==null|| text.trim().isEmpty){
      return "password_required".tr();
    }if(text.length<6){
      return "password_min_length".tr();
    }
    return null;
  }

  static String? validateConfirmPassword(String? text,String? originalPassword){
    if (text == null || text.trim().isEmpty) {
      return "repassword_required".tr();
    }
    if (text != originalPassword) {
      return "repassword_not_match".tr();
    }
    return null;
  }
  static String? validateTitle(String? text){
    if(text==null|| text.trim().isEmpty){
      return "title_required".tr();
    }
    return null;
  }
  static String? validateDescription(String? text){
    if(text==null|| text.trim().isEmpty){
      return "description_required".tr();
    }
    return null;
  }
}