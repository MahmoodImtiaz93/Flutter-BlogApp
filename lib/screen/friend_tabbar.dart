import 'package:blogapp/model/friendlist_model.dart';
 
import 'package:blogapp/screen/friendlist_screen.dart';
import 'package:blogapp/screen/sent_request_screen.dart';
import 'package:flutter/material.dart';

class FriendsTabBar extends StatefulWidget {
  final List<Friends> friendList;

  FriendsTabBar({
    Key? key,
    required this.friendList,
  }) : super(key: key);

  @override
  State<FriendsTabBar> createState() => _FriendsTabBarState();
}

class _FriendsTabBarState extends State<FriendsTabBar> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'Friend List',
                icon: Icon(Icons.people_alt_sharp),
              ),
              Tab(
                text: 'Sent Friend Requests',
                icon: Icon(Icons.send),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          FriendListScreen(friendList: widget.friendList),
          const SentRequestScreen()
        ]),
      ));
}
