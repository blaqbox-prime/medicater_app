import 'package:flutter/foundation.dart';

import 'address.dart';

class User {
  String? userId;
  String? username;
  String? userType;
  DateTime? date_created;
  String? password;

  User(
      {this.userId,
      this.username,
      this.userType,
      this.date_created,
      this.password});

  Map<String, dynamic> toUserMap() {
    return {
      'user_id': userId,
      'username': username,
      'date_created': date_created,
      'user_type': userType,
      'password': password,
    };
  }

  User.fromMap(Map<String, dynamic> data) {
    userId = data['user_id'];
    username = data['username'];
    userType = data['user_type'];
    date_created = DateTime.tryParse(data['date_created']);
  }

  void setUsername(newUsername) {
    this.username = newUsername;
  }
}

//setters
