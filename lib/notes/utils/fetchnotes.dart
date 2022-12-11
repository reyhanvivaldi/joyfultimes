import 'package:joyfultimes/notes/model/notesmodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
Future<List<NotesModel>> fetchNotes() async {
  var url = Uri.parse('https://joyfultimes.up.railway.app/newNotes/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin":"*",
      "Content-Type": "application/json",
    },
  );
  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<NotesModel> listNotes = [];
  for (var note in data) {
    if (note != null) {
      listNotes.add(NotesModel.fromJson(note));
    }
  }
  return listNotes;
}