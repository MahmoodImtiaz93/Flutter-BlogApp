import 'dart:convert';

import 'package:blogapp/constant/endpoints.dart';
import 'package:blogapp/services/apiresponse.dart';

import '../model/user_model.dart';
import 'package:http/http.dart' as http;
class UserServices {
//Register
  static Future<User> register(User user) async {
    
    Map data = {
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'password_confirmation': user.passwordconfirmation
    };

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/register'),
      body: jsonEncode(data),
     headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
     } 
  
    else {
      throw Exception('Failed to create note.');
    }
  }
}
