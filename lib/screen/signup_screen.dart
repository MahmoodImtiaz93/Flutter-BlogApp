import 'dart:developer';

import 'package:blogapp/components/button.dart';
import 'package:blogapp/components/custome_textfield.dart';
import 'package:blogapp/model/user_model.dart';
import 'package:blogapp/provider/auth_provider.dart';

import 'package:blogapp/utils/route_name.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:blogapp/model/user.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _singInFormKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> _obsecureConfirmPassword = ValueNotifier<bool>(true);

  void registerUser() {
 
    User registerUser = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
    
        passwordconfirmation: _confirmpasswordController.text);
    Provider.of<AuthProvider>(context, listen: false)
        .signup(registerUser, context);
  }

  EmailAuth emailAuth = EmailAuth(sessionName: 'MyApp');

  Future<void> requestOTP(String email) async {
    var response = await emailAuth.sendOtp(recipientMail: email);
    if (response) {
      print('OTP sent successfully');
    } else {
      print('Failed to send OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Sign Up",
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
                    controller: _nameController,
                    hintText: "Name",
                  )),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ValueListenableBuilder(
                  valueListenable: _obsecureConfirmPassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _confirmpasswordController,
                      obscureText: _obsecureConfirmPassword.value,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          hintText: 'Confirm Password',
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
                              _obsecureConfirmPassword.value =
                                  !_obsecureConfirmPassword.value;
                            },
                            child: Icon(_obsecureConfirmPassword.value
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
                title: 'Sign Up',
                onPress: () {
                  if (_singInFormKey.currentState!.validate()) {
                    registerUser();
                    requestOTP(_emailController.text);
                  }
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.loginscreen);
                },
                child: const Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Already have an account?  ",
                      style: TextStyle(color: Colors.white)),
                  TextSpan(
                    text: " Login here",
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
