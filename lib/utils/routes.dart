import 'package:blogapp/screen/signin_screen.dart';
import 'package:blogapp/screen/signup_screen.dart';
import 'package:blogapp/utils/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> genaratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.loginscreen:
        return MaterialPageRoute(builder: (context) => SignIn());
      case RouteNames.signupScreen:
        return MaterialPageRoute(
          builder: (context) => SignUp(),
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
