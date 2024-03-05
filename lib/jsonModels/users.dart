class Users {
  final int? usrId;
  final String userName;
  final String userEmail;
  final String userPassword;
  final String userPhoto;

  Users(
      {this.usrId,
      required this.userName,
      required this.userPassword,
      required this.userEmail,
      required this.userPhoto});

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      usrId: json["usrId"],
      userEmail: json["userEmail"],
      userName: json["userName"],
      userPassword: json["userPassword"],
      userPhoto: json['userPhoto']);

  Map<String, dynamic> toJson() => {
        "usrId": usrId,
        "userEmail": userEmail,
        "userName": userName,
        "userPassword": userPassword,
        "userPhoto": userPhoto
      };
}
