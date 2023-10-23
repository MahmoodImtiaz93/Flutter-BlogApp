import 'package:blogapp/screen/add_post_screen.dart';
import 'package:blogapp/screen/comment_screen.dart';
import 'package:blogapp/screen/home_screen.dart';
import 'package:blogapp/screen/nav_screen.dart';
import 'package:blogapp/screen/signin_screen.dart';
import 'package:blogapp/screen/signup_screen.dart';
import 'package:blogapp/utils/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> genaratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.loginscreen:
        return MaterialPageRoute(
          builder: (context) => SignIn(),
        );
      case RouteNames.signupScreen:
        return MaterialPageRoute(
          builder: (context) => SignUp(),
        );
      case RouteNames.navscreen:
        return MaterialPageRoute(
          builder: (context) => NavScreen(),
        );
      case RouteNames.homescreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case RouteNames.addpostscreen:
        return MaterialPageRoute(
          builder: (context) => AddPostScreen(isUpdate: false),
        );
        case RouteNames.commentscreen:
        return MaterialPageRoute(
          builder: (context) => CommentScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              body: Center(child: Text("No route found")),
            );
          },
        );
    }
  }
}
