// To parse this JSON data, do
//
//     final loggedIn = loggedInFromJson(jsonString);

import 'dart:convert';

LoggedIn loggedInFromJson(String str) => LoggedIn.fromJson(json.decode(str));

String loggedInToJson(LoggedIn data) => json.encode(data.toJson());

class LoggedIn {
  LoggedIn({
    required this.username,
  });

  String username;

  factory LoggedIn.fromJson(Map<String, dynamic> json) => LoggedIn(
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
  };
}