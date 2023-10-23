import 'dart:convert';

import 'dart:io';

import 'package:blogapp/constant/error_handaling.dart';
import 'package:blogapp/model/single_user.dart';

import 'package:blogapp/model/user_model.dart';

import 'package:blogapp/utils/route_name.dart';
import 'package:flutter/material.dart';

import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static void singUp(User user, BuildContext context) async {
    Map data = {
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'password_confirmation': user.passwordconfirmation,
    };
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/register'),
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      print('Response status code: ${response.statusCode}');

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

  // singin

  static void singIn(User user, BuildContext context) async {
    Map data = {
      'email': user.email,
      'password': user.password,
    };
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login'),
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      print('Response status code: ${response.statusCode}');
      print(json.decode(response.body));

      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () async {
          final responseData = json.decode(response.body);
          String _token = responseData['token'];
          int _id = responseData['user']['id'];
          String _userName = responseData['user']['name'];
          WidgetsFlutterBinding.ensureInitialized();
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('token', _token);
          await prefs.setInt('id', _id);
          await prefs.setString('name', _userName);

          Navigator.pushNamed(context, RouteNames.navscreen);
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

  static Future<bool> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.remove('token');
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

  static Future<void> updateProfilePicture(
      File imageFile, int userId, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8000/api/users/$userId'),
    );
    request.headers['Authorization'] = 'Bearer $token';

    request.files.add(await http.MultipartFile.fromPath(
      'profile_picture',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    try {
      var response = await request.send();
      var responseString = await response.stream.bytesToString();

      httpErrorHandle(
        response: http.Response(responseString, response.statusCode),
        context: context,
        onSuccess: () {
          Navigator.pop(context);
        },
      );
    } catch (e) {
      print('Error: $e');
    }
  }

// Get Users Information
  static Future<List<Users>> getUserInfo(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    List<Users> userInfo = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print("ON success userinfo");
          final responseData =
              jsonDecode(response.body) as Map<String, dynamic>;
          final userJson = responseData['users'] as Map<String, dynamic>;

          Users user = Users.fromJson(userJson);
          userInfo.add(user);

          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return userInfo;
  }
}
