import 'dart:convert';

import 'package:blogapp/constant/error_handaling.dart';
import 'package:blogapp/model/post_model.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/comment_model.dart';

class CommentServices {
  String? responseMessage;

  static Future<List<Comments>> getAllComments(
      int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    List<Comments> commentList = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/posts/$id/comments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          final responseData =
              jsonDecode(response.body) as Map<String, dynamic>;

          final List<dynamic> itemList = responseData['comments'];

          for (var item in itemList) {
            Comments comments = Comments.fromJson(item);
            commentList.add(comments);
          }
          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return commentList;
  }

  static void createComment(
    int id,
    Commentss comment,
    BuildContext context,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    Map data = {'comment': comment.comment};
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/posts/$id/comments'),
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print("Alhamulillah comment created");
          //print(post.body);
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

   static void updateComment(
    int id,
    Commentss comment,
    BuildContext context,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    Map data = {'comment': comment.comment};
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/comments/$id'),
        body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print("Alhamulillah comment update");
          //print(post.body);
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

   static void deleteComment(
    int id,
  
    BuildContext context,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
 
    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/comments/$id'),
        //body: jsonEncode(data),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print("Alhamulillah comment delete");
          //print(post.body);
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }
}
