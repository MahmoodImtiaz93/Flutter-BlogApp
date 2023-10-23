import 'dart:convert';

class UserModel {
  String? message;
  bool? success;
  
  User? user;
  
  UserModel({this.message,this.success,  this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
   
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = success;
   
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
 final String? id;
  final String? name;
  final String? lastname;
  final String? propic;
  final String? email;
  final String? token;
  final String? password;
 final String? passwordconfirmation;
  
  String? emailVerifiedAt;
  String? createdAt;

  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.lastname,
      this.propic,
      this.email,
      this.password,
      this.passwordconfirmation,
      this.token,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt});

  // User.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   lastname = json['lastname'];
  //   propic = json['propic'];
  //   email = json['email'];
  //   password =json['password'];
  //   token =json['token'];
  //   passwordconfirmation =json['password_confirmation'];
   
  //   emailVerifiedAt = json['email_verified_at'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = id;
  //   data['name'] = name;
  //   data['lastname'] = lastname;
  //   data['propic'] = propic;
  //   data['email'] = email;
  //   data['password'] = password;
  //   data['token'] = token;
  //   data['password_confirmation'] = passwordconfirmation;
 
  //   data['email_verified_at'] = emailVerifiedAt;
  //   data['created_at'] = createdAt;
  //   data['updated_at'] = updatedAt;
  //   return data;
  // }
  

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'propic': propic,
      'email': email,
      'token': token,
      'password': password,
      'passwordconfirmation': passwordconfirmation,
      'emailVerifiedAt': emailVerifiedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']??'',
      name:map['name']??'',
      lastname: map['lastname']??'',
      propic: map['propic']??'',
      email: map['email']??'',
      token: map['token']??'',
      password: map['password']??'',
      passwordconfirmation: map['passwordconfirmation']??'',
      emailVerifiedAt: map['emailVerifiedAt']??'',
      createdAt: map['createdAt']??'',
      updatedAt: map['updatedAt']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
