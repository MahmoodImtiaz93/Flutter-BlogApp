//import 'package:blogapp/model/user.dart';
import 'dart:io';

import 'package:blogapp/model/single_user.dart';
import 'package:blogapp/model/user_model.dart';
import 'package:blogapp/services/user_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  List<User> userModel = [];
  List<Users> singleUser = [];
  

  User _user = User(
      name: '', email: '', token: '', password: '', passwordconfirmation: '');

  User get user => _user;
  // UserServices userServices = UserServices();

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  String _userName = '';
  int? _userID;

  String get userName => _userName;
  int get userID => _userID ?? 0;
  

  Future<void> fetchUserName() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('name') ?? '';
    _userID = prefs.getInt('id');
    notifyListeners();
  }
 

  void signup(User user, BuildContext context) async {
    userModel.add(user);
    UserServices.singUp(user, context);
    notifyListeners();
  }

  getUserInfo(BuildContext context) async {
    singleUser = await UserServices.getUserInfo(context);
    notifyListeners();
    print("userinfo provider");
    //notify Dart of change so Dart knows to update the UI.
  }

  void updateProfilePic(BuildContext context, int id, File imageFile) {
    UserServices.updateProfilePicture(imageFile, id, context);
  }

  void signin(User user, BuildContext context) async {
    userModel.add(user);
    UserServices.singIn(user, context);
    notifyListeners();
  }

  Future<bool> userlogout() async {
    UserServices.logout();
    notifyListeners();
    return true;
  }

 
}
