import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

postData(CookieRequest request, Map items) async {
  var data = convert.jsonEncode(
    <String, dynamic>{
      "sender": items['sender'],
      "title": items['title'],
      "notes": items['body'],
    },
  );

  final response = await request.post(
    'https://joyfultimes.up.railway.app/newNotes/createfromflutter/',
    data,
  );
}
