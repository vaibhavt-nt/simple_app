class Users {
  final int? usrId;
  final String userName;
  final String userPassword;

  Users({
    this.usrId,
    required this.userName,
    required this.userPassword,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        usrId: json["usrId"],
        userName: json["userName"],
        userPassword: json["userPassword"],
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "userName": userName,
        "userPassword": userPassword,
      };
}
