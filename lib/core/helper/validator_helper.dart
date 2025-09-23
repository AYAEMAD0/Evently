class ValidatorHelper{
  static String? validateName(String? text){
  if (text == null || text.trim().isEmpty) {
  return "Name is required";
  }
  if (text.length < 3) {
  return "Name must be at least 3 characters";
  }
  return null;
  }

  static String? validateEmail(String? text){
    if (text == null || text.trim().isEmpty) {
      return "Email is required";
    }
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(text);
    if (!emailValid) {
      return "Email is invalid";
    }
    return null;
  }
  static String? validatePassword(String? text){
  if(text==null|| text.trim().isEmpty){
  return "Password is required";
  }if(text.length<6){
  return "Password must be least at 6";
  }
  return null;
  }

  static String? validateConfirmPassword(String? text,String? originalPassword){
  if (text == null || text.trim().isEmpty) {
  return "Re Password is required";
  }
  if (text != originalPassword) {
  return "Re Password must match Password";
  }
  return null;
  }
}