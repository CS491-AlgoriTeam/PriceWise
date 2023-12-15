import 'dart:convert';

class User {
  final int userID;
  final String userName;
  final String userSurname;
  final String userEmail;
  final String userPassword;

  User({
    required this.userID,
    required this.userName,
    required this.userSurname,
    required this.userEmail,
    required this.userPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'userName': userName,
      'userSurname': userSurname,
      'userEmail': userEmail,
      'userPassword': userPassword,
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        userName = map['userName'],
        userSurname = map['userSurname'],
        userEmail = map['userEmail'],
        userPassword = map['userPassword'];

  factory User.fromJSON(Map<String, dynamic> json) => User(
      userID: json['userID'],
      userName: json['userName'],
      userSurname: json['userSurname'],
      userEmail: json['userEmail'],
      userPassword: json['userPassword']);

  Map<String, dynamic> toJSON() => {
        'userID': userID,
        'userName': userName,
        'userSurname': userSurname,
        'userEmail': userEmail,
        'userPassword': userPassword
      };
      
  @override
  String toString() {
    return 'User{userID: $userID, userName: $userName, userSurname: $userSurname, userEmail: $userEmail, userPassword: $userPassword}';
  }

  // getters and setters
  int getUserID() {
    return userID;
  }

  String getUserName() {
    return userName;
  }

  String getUserSurname() {
    return userSurname;
  }

  String getUserEmail() {
    return userEmail;
  }

  String getUserPassword() {
    return userPassword;
  }
}
