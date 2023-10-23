import 'dart:convert';

import 'package:blogapp/constant/error_handaling.dart';
import 'package:blogapp/model/friendlist_model.dart';
import 'package:blogapp/model/pendding_request.dart';
import 'package:blogapp/model/searchuser_model.dart';
import 'package:blogapp/model/sentfnd_request.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class FriendsServices {
  //Get Friendlist
  static Future<List<Friends>> friendlist(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    List<Friends> friends = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/friend-list'),
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

          final List<dynamic> itemList = responseData['friends'];

          for (var item in itemList) {
            Friends friendlist = Friends.fromJson(item);
            friends.add(friendlist);
          }
          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return friends;
  }

  //Get Pending Requests
  static Future<List<PendingRequests>> pendingFriendList(
      BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    List<PendingRequests> pendingFriendRequests = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/friend-requests'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print('OnSuccesssss');
          final responseData =
              jsonDecode(response.body) as Map<String, dynamic>;

          final List<dynamic> itemList = responseData['pendingRequests'];

          for (var item in itemList) {
            PendingRequests pendingFriendList = PendingRequests.fromJson(item);
            pendingFriendRequests.add(pendingFriendList);
          }
          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return pendingFriendRequests;
  }

// sent friend request
  static Future<List<SentRequests>> sentFriendRrequest(
      BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    List<SentRequests> sentFriendRequests = [];
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/friends/sent-request'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print('OnSuccesssss');
          final responseData =
              jsonDecode(response.body) as Map<String, dynamic>;

          final List<dynamic> itemList = responseData['sentRequests'];

          for (var item in itemList) {
            SentRequests sentreq = SentRequests.fromJson(item);
            sentFriendRequests.add(sentreq);
          }
          print(response.body);
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return sentFriendRequests;
  }

// send friend request
  static Future<void> acceptFriendRequest(int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/friend-requests/accept/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {}
  }

  // cancle sent Requests
  static Future<void> cancleSentRequests(int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/friend-requests/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print("Friend Request Cancle");
        },
      );
    } catch (e) {}
  }

  //accept friend request
  static Future<void> sendFriendRequest(int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/friend-requests/send/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {}
  }

//decline friend request
  static Future<void> declineFriendRequest(int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/friend-requests/decline/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {}
  }

//delete accepted friend from friendlist
  static Future<void> deleteFriend(int id, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/friend-requests/delete/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print("Friend Deleted");
        },
      );
    } catch (e) {}
  }

  // search friend
  //Get Friendlist
  static Future<List<Users>> searchFriends(
      String query, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    List<Users> searchedfriends = [];

    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/friends/search?query=$query'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          print("On Success");
          final responseData =
              jsonDecode(response.body) as Map<String, dynamic>;

          final List<dynamic> itemList = responseData['users'];

          for (var item in itemList) {
            Users friendlist = Users.fromJson(item);
            searchedfriends.add(friendlist);
          }
          print(response.body + "Response Body");
        },
      );

      //return the list of all the post object in it.
    } catch (e) {}
    return searchedfriends;
  }
}
