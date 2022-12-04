import 'package:joyfultimes/forumpost.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
Future<List<ForumPost>> fetchForumPost() async {
  var url = Uri.parse('https://joyfultimes.up.railway.app/forum/flutterForum/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin":"*",
      "Content-Type": "application/json",
    },
  );
  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<ForumPost> listForumPost = [];
  for (var forum in data) {
    if (forum != null) {
      listForumPost.add(ForumPost.fromJson(forum));
    }
  }
  return listForumPost;
}