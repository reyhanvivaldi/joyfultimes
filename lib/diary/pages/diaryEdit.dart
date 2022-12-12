import 'package:flutter/material.dart';
import 'package:joyfultimes/diary/model/model.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:joyfultimes/diary/pages/diaryHome.dart';
import 'dart:convert';
import 'package:http/http.dart';

class DiaryEdit extends StatefulWidget {
  const DiaryEdit({super.key, required this.pk, required this.diaryItems});
  final int pk;
  final Diary diaryItems;

  @override
  State<DiaryEdit> createState() => _DiaryEditState();
}

class _DiaryEditState extends State<DiaryEdit> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String body = "";

  void postEditData(request, title, body, int pk) async {
    var rawdata = {'title': title, 'body': body};
    var toJson = json.encode(
      rawdata,
    );
    print(toJson);
    String url = "https://joyfultimes.up.railway.app/diary/edit/update/$pk";

    // Error. Does Provider package support updating by id?
    final response = await request.post(url, rawdata);

    // var response = await post(
    //   Uri.parse(url),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(rawdata),
    //   encoding: Encoding.getByName('utf-8'),
    // );

    if (response['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Diary saved!"),
        backgroundColor: Colors.green,
      ));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DiaryHome()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Sorry, there's an error occured!"),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit diary'),
      ),
      drawer: const MyDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.diaryItems.fields.title,
                    decoration: InputDecoration(
                      hintText: "Diary hari ini",
                      labelText: "Title",
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        title = value!;
                      });
                      print("Edited title: $title");
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        title = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Title can not be empty!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: widget.diaryItems.fields.body,
                    decoration: InputDecoration(
                      hintText: "Hari ini aku bahagia, ...",
                      labelText: "Body",
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        body = value!;
                      });
                      print("Edited body: $body");
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        body = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Body can not be empty!';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      // shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(14))),
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        int id = widget.diaryItems.pk;
                        title = title == ""
                            ? widget.diaryItems.fields.title
                            : title;
                        body =
                            body == "" ? widget.diaryItems.fields.body : body;
                        postEditData(request, title, body, id);
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      // shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(14))),
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    child: const Text(
                      'Back',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
