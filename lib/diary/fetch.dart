import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:joyfultimes/diary/model/model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Diary>> fetchToDo(CookieRequest request) async {
  // var url = Uri.parse('https://joyfultimes.up.railway.app/diary/json/');
  // var response = await http.get(
  //   url,
  //   headers: {
  //     "Access-Control-Allow-Origin": "*",
  //     "Content-Type": "application/json",
  //   },
  // );

  final response =
      await request.get('https://joyfultimes.up.railway.app/diary/json/');

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Diary
  List<Diary> listDiary = [];
  for (var d in data) {
    if (d != null) {
      listDiary.add(Diary.fromJson(d));
    }
  }

  return listDiary;
}
