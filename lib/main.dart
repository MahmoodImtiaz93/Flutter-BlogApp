import 'package:blogapp/provider/userdataprovider.dart';
import 'package:blogapp/screen/homescreen.dart';
import 'package:blogapp/screen/loading.dart';
import 'package:blogapp/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => UserDataProvider(),
          )
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                //primarySwatch: Colors.blue,
                primaryColor: Colors.black,
                colorScheme: ColorScheme.light(primary: Colors.white)),
            home: SignUp()));
  }
}
