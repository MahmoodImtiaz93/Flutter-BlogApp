import 'package:blogapp/provider/post_provider.dart';
 
import 'package:blogapp/screen/friends_feed_sreen.dart';
import 'package:blogapp/screen/home_screen.dart';
import 'package:blogapp/screen/profile_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int index = 0;
  int userID = 0;

  @override
  void initState() {
    super.initState();
    fetchUserID(); // Call the method to fetch userID
  }

  void fetchUserID() {
    Provider.of<PostProvider>(context, listen: false)
        .savedUserInfo()
        .then((String? userInfo) {
      if (userInfo != null) {
        setState(() {
          userID = int.parse(userInfo);
        });
      }
    });
  }
 

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: index,
          backgroundColor: Colors.transparent,
          color: Colors.black,
          animationDuration: const Duration(milliseconds: 250),
          items: <Widget>[
            const Icon(
              Icons.public,
              size: 30,
              color: Colors.white,
            ),
            const Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            const Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
        ),
        body: //screens[index],
            Container(
          color: Colors.transparent,
          child: getSelectedWidget(index: index),
        ),
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = HomeScreen();
        break;
      
      case 1:
        widget = FriendsFeed();
        break;

      default:
        widget = ProfileScreen(
          userID: userID,
        );
        break;
    }
    return widget;
  }
}
