abstract class AuthInterface{
  void showLoading({String? message});
  void hideLoading();
  void showMessage({String? message, String? title,Function?posActionClick});
}