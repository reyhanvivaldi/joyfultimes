import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

postData(CookieRequest request, Map items) async {
  var data = convert.jsonEncode(
    <String, dynamic>{
      "title": items['title'],
      "description": items['body'],
    },
  );

  final response = await request.post(
    'https://joyfultimes.up.railway.app/diary/add-obj/',
    data,
  );
}
