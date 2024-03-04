import 'dart:convert';

Users usersFromMap(String str) => Users.fromMap(json.decode(str));

String usersToMap(Users data) => json.encode(data.toMap());

class Users {
  final int? usrId;
  final String userName;
  final String userEmail;
  final String userPassword;

  Users({
    this.usrId,
    required this.userName,
    required this.userPassword,
    required this.userEmail,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        usrId: json["usrId"],
        userEmail: json["userEmail"],
        userName: json["userName"],
        userPassword: json["userPassword"],
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "userEmail": userEmail,
        "userName": userName,
        "userPassword": userPassword,
      };
}
