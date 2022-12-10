import 'package:joyfultimes/forum/models/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
Future<List<Comment>> fetchComment(id) async {
  var url = Uri.parse('https://joyfultimes.up.railway.app/forum/flutterComment/${id}/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin":"*",
      "Content-Type": "application/json",
    },
  );
  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<Comment> listComment = [];
  for (var comment in data) {
    if (comment != null) {
      listComment.add(Comment.fromJson(comment));
    }
  }
  return listComment;
}