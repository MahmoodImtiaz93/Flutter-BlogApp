import 'package:blogapp/model/friendlist_model.dart';
import 'package:blogapp/model/pendding_request.dart';
import 'package:blogapp/model/searchuser_model.dart';
import 'package:blogapp/model/sentfnd_request.dart';
import 'package:blogapp/services/friends_services.dart';
import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';

class FriendListProvider extends ChangeNotifier {
  List<Friends> friendLists = [];
  List<PendingRequests> pendingFriendLists = [];
  List<Users> searchedFriends = [];
  List<SentRequests> sentRequestList = [];
  //SentRequests sentRequests = SentRequests();

  getFriendlist(BuildContext context) async {
    friendLists = await FriendsServices.friendlist(context);
    notifyListeners();
    print(
        "Get Friend Lists from Provider"); //notify Dart of change so Dart knows to update the UI.
  }

  getSentFriendRequest(BuildContext context) async {
    sentRequestList = await FriendsServices.sentFriendRrequest(context);
    notifyListeners();
    print(
        "Get Sent Friend Lists from Provider"); //notify Dart of change so Dart knows to update the UI.
  }

  getSearchedFriendlist(String query, BuildContext context) async {
    searchedFriends = await FriendsServices.searchFriends(query, context);
    notifyListeners();
  }

  void clearSearchedFriends() {
    searchedFriends = [];
    notifyListeners();
  }

  getPendingFriendlist(BuildContext context) async {
    pendingFriendLists = await FriendsServices.pendingFriendList(context);
    notifyListeners();
    print(
        "Get Pending Friend Lists from Provider"); //notify Dart of change so Dart knows to update the UI.
  }

  acceptRequest(int id, BuildContext context) {
    FriendsServices.acceptFriendRequest(id, context);
    notifyListeners();
  }

  sendRequest(int id, BuildContext context) {
    FriendsServices.sendFriendRequest(id, context);
    notifyListeners();
  }

  declineRequest(int id, BuildContext context) {
    FriendsServices.declineFriendRequest(id, context);
    notifyListeners();
  }

  deleteFriend(int id, BuildContext context) {
    FriendsServices.deleteFriend(id, context);
    notifyListeners();
  }

  cancleSentRequest(int id, BuildContext context) {
  int indexOfNote = sentRequestList.indexWhere((element) => element.requestId == id);
  if (indexOfNote != -1) {
    sentRequestList.removeAt(indexOfNote);
  }

    FriendsServices.cancleSentRequests(id, context);
    notifyListeners();
  }
}
