import 'package:blogapp/components/button.dart';
import 'package:blogapp/model/user_model.dart';
import 'package:blogapp/provider/auth_provider.dart';
import 'package:blogapp/utils/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custome_textfield.dart';

class SignIn extends StatefulWidget {
  final _singInFormKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> _obsecureConfirmPassword = ValueNotifier<bool>(true);
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _singInFormKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> _obsecureConfirmPassword = ValueNotifier<bool>(true);

  void signInUser() {
    
    User signIn =
        User(email: _emailController.text, password: _passwordController.text);
 

    Provider.of<AuthProvider>(context, listen: false).signin(signIn, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Log In",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        )),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _singInFormKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomTextField(
                      controller: _emailController, hintText: "Email")),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ValueListenableBuilder(
                  valueListenable: _obsecurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: _obsecurePassword.value,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          _passwordController = value as TextEditingController,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle:
                              TextStyle(fontSize: 16.0, color: Colors.white),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 3, color: Colors.white),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                            child: Icon(_obsecurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          suffixIconColor: Colors.white),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundButton(
                title: 'Sign In',
                onPress: () {
                  if (_singInFormKey.currentState!.validate()) {
                    //  registerUser();
                    signInUser();
                  }
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.signupScreen);
                },
                child: const Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Do not have an account?  ",
                      style: TextStyle(color: Colors.white)),
                  TextSpan(
                    text: " Sign Up Here",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
