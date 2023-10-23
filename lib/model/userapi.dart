// import 'dart:convert';

// /// message : "User create successfully"
// /// user : {"name":"bello","email":"b1edlxdlo@gmail.com","password":"123456","password_confirmation":"123456","updated_at":"2023-01-04T06:14:52.000000Z","created_at":"2023-01-04T06:14:52.000000Z","id":39}
// /// token : "40|AgwwQXhFmj4C9DrMLEB4E9axV1Kd6xaypcPVFcVJ"

// class Userapi {
//   Userapi({
//       String? message, 
//       User? user, 
//       String? token,}){
//     _message = message;
//     _user = user;
//     _token = token;
// }

//   Userapi.fromJson(dynamic json) {
//     _message = json['message'];
//     _user = json['user'] != null ? User.fromJson(json['user']) : null;
//     _token = json['token'];
//   }
//   String? _message;
//   User? _user;
//   String? _token;
// Userapi copyWith({  String? message,
//   User? user,
//   String? token,
// }) => Userapi(  message: message ?? _message,
//   user: user ?? _user,
//   token: token ?? _token,
// );
//   String? get message => _message;
//   User? get user => _user;
//   String? get token => _token;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['message'] = _message;
//     if (_user != null) {
//       map['user'] = _user?.toJson();
//     }
//     map['token'] = _token;
//     return map;
//   }

// }

// /// name : "bello"
// /// email : "b1edlxdlo@gmail.com"
// /// password : "123456"
// /// password_confirmation : "123456"
// /// updated_at : "2023-01-04T06:14:52.000000Z"
// /// created_at : "2023-01-04T06:14:52.000000Z"
// /// id : 39

// class User {
//   User({
//       String? name, 
//       String? email, 
//       String? password, 
//       String? passwordConfirmation, 
//       String? updatedAt, 
//       String? createdAt, 
//       int? id,}){
//     _name = name;
//     _email = email;
//     _password = password;
//     _passwordConfirmation = passwordConfirmation;
//     _updatedAt = updatedAt;
//     _createdAt = createdAt;
//     _id = id;
// }

//   User.fromJson(dynamic json) {
//     _name = json['name'];
//     _email = json['email'];
//     _password = json['password'];
//     _passwordConfirmation = json['password_confirmation'];
//     _updatedAt = json['updated_at'];
//     _createdAt = json['created_at'];
//     _id = json['id'];
//   }
//   String? _name;
//   String? _email;
//   String? _password;
//   String? _passwordConfirmation;
//   String? _updatedAt;
//   String? _createdAt;
//   int? _id;
// User copyWith({  String? name,
//   String? email,
//   String? password,
//   String? passwordConfirmation,
//   String? updatedAt,
//   String? createdAt,
//   int? id,
// }) => User(  name: name ?? _name,
//   email: email ?? _email,
//   password: password ?? _password,
//   passwordConfirmation: passwordConfirmation ?? _passwordConfirmation,
//   updatedAt: updatedAt ?? _updatedAt,
//   createdAt: createdAt ?? _createdAt,
//   id: id ?? _id,
// );
//   String? get name => _name;
//   String? get email => _email;
//   String? get password => _password;
//   String? get passwordConfirmation => _passwordConfirmation;
//   String? get updatedAt => _updatedAt;
//   String? get createdAt => _createdAt;
//   int? get id => _id;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['name'] = _name;
//     map['email'] = _email;
//     map['password'] = _password;
//     map['password_confirmation'] = _passwordConfirmation;
//     map['updated_at'] = _updatedAt;
//     map['created_at'] = _createdAt;
//     map['id'] = _id;
//     return map;
//   }
//   //String toJson() => json.encode(toMap());
// }