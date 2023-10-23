import 'package:blogapp/provider/auth_provider.dart';
import 'package:blogapp/provider/comment_provider.dart';
import 'package:blogapp/provider/friendlist_provider.dart';
import 'package:blogapp/provider/post_provider.dart';
import 'package:blogapp/screen/home_screen.dart';
//import 'package:blogapp/provider/userdataprovider.dart';
import 'package:blogapp/screen/loading.dart';
import 'package:blogapp/screen/nav_screen.dart';
import 'package:blogapp/screen/signin_screen.dart';
import 'package:blogapp/screen/signup_screen.dart';
import 'package:blogapp/utils/route_name.dart';
import 'package:blogapp/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp(this.token, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(),
          child: HomeScreen(),
        ),
        ChangeNotifierProvider(
          create: (context) => CommentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FriendListProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          //primarySwatch: Colors.blue,
          primaryColor: Colors.black,
          colorScheme: ColorScheme.light(primary: Colors.white),
          // useMaterial3: true,
        ),
        // initialRoute: RouteNames.signupScreen,
        home: token != null ? NavScreen() : SignIn(),
        onGenerateRoute: Routes.genaratedRoute,
      ),
    );
  }
}
