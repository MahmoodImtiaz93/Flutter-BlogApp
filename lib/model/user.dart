// import 'dart:convert';

// class User {
  
//   final String name;
//   final String email;
//   final String token;
//   final String password;
//   final String password_confirmation;

//   User({
   
//    required this.name,
//    required this.email,
//    required this.token,
//    required this.password,
//    required this.password_confirmation,
// });



//   Map<String, dynamic> toMap() {
//     return {
    
//       'name': name,
//       'email': email,
//       'token': token,
//       'password': password,
//       'password_confirmation': password_confirmation,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
      
//       name: map['name'] ?? '',
//       email: map['email'] ?? '',
//       token: map['token'] ?? '',
//       password: map['password'] ?? '',
//       password_confirmation: map['password_confirmation'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source));
// }
