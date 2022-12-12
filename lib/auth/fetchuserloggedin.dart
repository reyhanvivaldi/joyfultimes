import 'package:joyfultimes/auth/userloggedin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<LoggedIn>> fetchUserLoggedIn() async {
  var url = Uri.parse('https://joyfultimes.up.railway.app/auth/data/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // Apakah data ini iterable? Kalo ga, ini eror. Muncul di terminal waktu akses homepage - rey
  var data = jsonDecode(utf8.decode(response.bodyBytes));
  List<LoggedIn> listLoggedIn = [];
  for (var user in data) {
    if (user != null) {
      listLoggedIn.add(LoggedIn.fromJson(user));
    }
  }

  return listLoggedIn;
}
