import 'package:evently/firebase/model/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier{
  UserModel? currentUser;

  void changeCurrentUser(UserModel newUser){
    currentUser=newUser;
    notifyListeners();
  }
}