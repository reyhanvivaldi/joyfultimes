import 'package:joyfultimes/notes/model/notesmodel.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<List<NotesModel>> fetchUserNotes(CookieRequest request) async {
  var response =
      await request.get('https://joyfultimes.up.railway.app/newNotes/alljson');

  List<NotesModel> listNotes = [];
  for (var d in response) {
    if (d != null) {
      listNotes.add(NotesModel.fromJson(d));
    }
  }

  return listNotes;
}