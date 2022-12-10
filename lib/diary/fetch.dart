import 'package:joyfultimes/diary/model/model.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<Diary>> fetchToDo(CookieRequest request) async {
  var response =
      await request.get('https://joyfultimes.up.railway.app/diary/json/');

  List<Diary> listDiary = [];
  for (var d in response) {
    if (d != null) {
      listDiary.add(Diary.fromJson(d));
    }
  }

  return listDiary;
}
