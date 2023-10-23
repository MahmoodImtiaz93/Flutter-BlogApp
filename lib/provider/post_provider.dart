import 'package:blogapp/model/friends_post.dart';
import 'package:blogapp/model/likedRecived.dart';
import 'package:blogapp/model/liked_given.dart';
import 'package:blogapp/model/post_model.dart';
import 'package:blogapp/services/post_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class PostProvider extends ChangeNotifier {
  List<Posts> postModel = [];
  List<Posts> userAllPost = [];

  List<FriendPosts> friendspostList = [];
  List<ReceivedLikes> recivedLikesList = [];
  List<LikedPosts> likedPostsList = [];
  String _message = '';
  String get message => _message;
  String? id;

  void createPost(Posts post, BuildContext context) {
    postModel.add(post);
    notifyListeners();
    PostServices.createPost(post, context);
    notifyListeners();
  }

 

  Future<void> likeUnlikepost(int id, BuildContext context) async {
    notifyListeners();
    try {
      // Make the API call and update the like status and count
      await PostServices.likeUnlikePost(id, context);
      // Notify listeners that the data has changed
      notifyListeners();
    } catch (e) {
      print('Error: $e');
      // Handle the error
    }
  }

  void deletePost(int id, BuildContext context) {
    int indexOfNote = userAllPost.indexWhere((element) => element.id == id);
    if (indexOfNote != -1) {
      userAllPost.removeAt(indexOfNote);
      notifyListeners();
    }
    PostServices.deletePost(id, context);
    notifyListeners();
  }

  void deleteHome_Post(int id, BuildContext context) {
    int indexOfNote = postModel.indexWhere((element) => element.id == id);
    if (indexOfNote != -1) {
      postModel.removeAt(indexOfNote);
      notifyListeners();
    }
    PostServices.deletePost(id, context);
    notifyListeners();
  }

  getAllPosts(BuildContext context) async {
    postModel = await PostServices.getAllPosts(context);
    notifyListeners();
    print(
        "Get all post called from provider"); //notify Dart of change so Dart knows to update the UI.
  }

  getfriendsPosts(BuildContext context) async {
    friendspostList = await PostServices.getfriendsPosts(context);
    notifyListeners();
    print(
        "Get friends post called from provider"); //notify Dart of change so Dart knows to update the UI.
  }

  getUsersAllPosts(id, BuildContext context) async {
    userAllPost = await PostServices.getUsersPosts(id, context);
    notifyListeners();
    print("getUsersAllPosts/provider");
  }

  getRecivedLikes(id, BuildContext context) async {
    recivedLikesList = await PostServices.likedRecivedpost(id, context);
    notifyListeners();
    print("likedRecivedpost/provider");
  }

  getLikedPosts(id, BuildContext context) async {
    likedPostsList = await PostServices.likedGiven(id, context);
    notifyListeners();
    print("likedgiven/provider");
  }

  Future<String> savedUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    return id.toString();
  }

  void updatePost(id, Posts post, BuildContext context) {
    final index = postModel.indexWhere((element) => element.id == post.id);
    if (index != -1) {
      postModel[index] = post;
      notifyListeners();
      PostServices.updatePost(id, post, context);
    } else {
      print('Error: No element found with the specified ID');
    }
  }
}
