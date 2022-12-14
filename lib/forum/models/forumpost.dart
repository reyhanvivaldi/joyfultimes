// To parse this JSON data, do
//
//     final forumPost = forumPostFromJson(jsonString);

import 'dart:convert';

List<ForumPost> forumPostFromJson(String str) => List<ForumPost>.from(json.decode(str).map((x) => ForumPost.fromJson(x)));

String forumPostToJson(List<ForumPost> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ForumPost {
  ForumPost({
    required this.pk,
    required this.author,
    required this.topic,
    required this.description,
    required this.dateCreated,
    required this.role,
  });

  int pk;
  String author;
  String topic;
  String description;
  DateTime dateCreated;
  String role;

  factory ForumPost.fromJson(Map<String, dynamic> json) => ForumPost(
    pk: json["pk"],
    author: json["author"],
    topic: json["topic"],
    description: json["description"],
    dateCreated: DateTime.parse(json["date_created"]),
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "author": author,
    "topic": topic,
    "description": description,
    "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
    "role": role,
  };
}
