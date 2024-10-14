// // To parse this JSON data, do
// //
// //     final users = usersFromMap(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// Users usersFromMap(String str) => Users.fromMap(json.decode(str));

// String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? userId;
  final String userName;
  final String userPassword;

  Users({
    this.userId,
    required this.userName,
    required this.userPassword,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        userName: json["userName"],
        userPassword: json["userPassword"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "userName": userName,
        "userPassword": userPassword,
      };
}
