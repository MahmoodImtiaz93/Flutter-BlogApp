import 'package:blogapp/model/user_model.dart';
import 'package:blogapp/services/user_services.dart';
import 'package:flutter/cupertino.dart';

class UserDataProvider extends ChangeNotifier{

  List<User> userModel = [];

  void register(User user) async{
    userModel.add(user);
     notifyListeners();

     UserServices.register(user);
     notifyListeners();
  }


}