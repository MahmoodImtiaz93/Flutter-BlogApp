import 'dart:convert';

import 'package:blogapp/constant/error_handaling.dart';
import 'package:blogapp/model/friends_post.dart';
import 'package:blogapp/model/likedRecived.dart';
import 'package:blogapp/model/liked_given.dart';
import 'package:blogapp/model/post_model.dart';
import 'package:blogapp/provider/auth_provider.dart';
import 'package:blogapp/utils/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:blogapp/services/user_services.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

 
class PostServices {
  static void createPost(Posts post, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print(token);
    print(post.image);

    // Create the multipart request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:8000/api/posts'),
    );

    // Set the headers
    request.headers['Authorization'] = 'Bearer $token';

    // Add the text fields
    request.fields['body'] = post.body!;

    // Add the image file
    if (post.image != null) {
      var file = await http.MultipartFile.fromPath('image', post.image!);
      request.files.add(file);
    }

    try {
      // Send the request
      var response = await request.send();

      // Convert the response to a string
      var responseString = await response.stream.bytesToString();

      // Handle the response
      httpErrorHandle(
        response: http.Response(responseString, response.statusCode),
        context: context,
        onSuccess: () {
          Navigator.pushNamed(context, RouteNames.navscreen);
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: $responseString');
      print(post.image);
    } catch (e) {
      print('Error: $e');
    }
  }





  

  // get All posts

  static Future<List<Posts>> getAllPosts(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getInt('id');

    //final id = int.tryParse(intid ?? '');
    //  print(id);
    List<Posts> postList = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/posts'),
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

          final List<dynamic> itemList = responseData['posts'];

          for (var item in itemList) {
            Posts post = Posts.fromJson(item);
            postList.add(post);
          }
          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return postList;
  }

//getonly friends posts
  static Future<List<FriendPosts>> getfriendsPosts(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final id = prefs.getInt('id');
 
    List<FriendPosts> postList = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/friend-posts'),
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

          final List<dynamic> itemList = responseData['posts'];

          for (var item in itemList) {
            FriendPosts post = FriendPosts.fromJson(item);
            postList.add(post);
          }
          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return postList;
  }

  static Future<String> likeUnlikePost(int postId, BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/posts/$postId/likes'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print("Alhamulillah post Liked");
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final message = jsonResponse['message'];
        return message;
      } else {
        throw Exception('Failed to like/unlike post');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while liking/unliking the post');
    }
  }

  static void updatePost(String id, Posts post, BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);

    Map data = {'body': post.body};
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/posts/$id'),
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
          Navigator.pushNamed(context, RouteNames.navscreen);
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (e) {
      print('Error: $e');
    }
  }

  //get all posts of a user
  // get All posts

  static Future<List<Posts>> getUsersPosts(int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // final id = prefs.getInt('id');

    //final id = int.tryParse(intid ?? '');
    //  print(id);
    List<Posts> postList = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/users/$id/posts'),
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

          final List<dynamic> itemList = responseData['posts'];

          for (var item in itemList) {
            Posts post = Posts.fromJson(item);
            postList.add(post);
          }
          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return postList;
  }

  //liked recived post
  static Future<List<ReceivedLikes>> likedRecivedpost(
      int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    // final id = prefs.getInt('id');

    //final id = int.tryParse(intid ?? '');
    //  print(id);
    List<ReceivedLikes> recivedLikesLists = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/users/$id/received-likes'),
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

          final List<dynamic> itemList = responseData['receivedLikes'];

          for (var item in itemList) {
            ReceivedLikes recivedLikes = ReceivedLikes.fromJson(item);
            recivedLikesLists.add(recivedLikes);
          }
          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return recivedLikesLists;
  }

  //LikedGiven

  static Future<List<LikedPosts>> likedGiven(
      int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
   
    List<LikedPosts> likedPosts = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/users/$id/liked-posts'),
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

          final List<dynamic> itemList = responseData['likedPosts'];

          for (var item in itemList) {
            LikedPosts givenLiked = LikedPosts.fromJson(item);
            likedPosts.add(givenLiked);
          }
          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return likedPosts;
  }



static void deletePost(
    int id,
    BuildContext context,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
 
    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/posts/delete/$id'),
      
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print("Alhamulillah Post delete");
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
