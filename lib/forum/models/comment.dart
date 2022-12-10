// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

List<Comment> commentFromJson(String str) => List<Comment>.from(json.decode(str).map((x) => Comment.fromJson(x)));

String commentToJson(List<Comment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comment {
  Comment({
    required this.pk,
    required this.author,
    required this.parentForum,
    required this.description,
    required this.role,
    required this.dateCreated,
  });

  int pk;
  String author;
  int parentForum;
  String description;
  String role;
  DateTime dateCreated;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    pk: json["pk"],
    author: json["author"],
    parentForum: json["parentForum"],
    description: json["description"],
    role: json["role"],
    dateCreated: DateTime.parse(json["date_created"]),
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "author": author,
    "parentForum": parentForum,
    "description": description,
    "role": role,
    "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
  };
}
