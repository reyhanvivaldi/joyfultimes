import 'package:flutter/material.dart';
import 'package:joyfultimes/notes/pages/notes.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/notes/utils/fetchnotes.dart';
import 'package:joyfultimes/notes/model/notesmodel.dart';
import 'package:joyfultimes/notes/pages/notesform.dart';
import 'package:joyfultimes/notes/pages/notesuser.dart';
import 'package:joyfultimes/auth/loginpage.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

List<Map> newNote = [];

class NotesForm extends StatefulWidget {
  const NotesForm({super.key});

  @override 
  State<NotesForm> createState() => _NotesFormState();
}

class _NotesFormState extends State<NotesForm> {
  final _formKey = GlobalKey<FormState>();

  String _sender = "";
  String _title = "";
  String _notes = "";

  @override
  Widget build(BuildContext context){
    final request = context.watch<CookieRequest>();
    if (!request.loggedIn) {
      print("Cannot send notes! You must login first!");
      return Scaffold(
        appBar: AppBar(
          title: const Text("Notes | JoyfulTimes"),
        ),
        drawer: const MyDrawer(),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                "Sorry, you must login first!",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromARGB(178, 3, 3, 3)),
              ),
            ),
          ),
          ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14))),
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                "Go to login page",
                style: TextStyle(color: Colors.white),
              )),
        ]),
      );
    } else {}
    return Scaffold(
      appBar: AppBar(
        title: Text('Send a Note'),
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
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Who sent this?",
                            labelText: "Sender",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                        ),
                        // Menambahkan behavior saat nama diketik 
                        onChanged: (String? value) {
                            setState(() {
                                _sender = value!;
                            });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                            setState(() {
                                _sender = value!;
                            });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return 'Judul tidak boleh kosong!';
                            }
                            return null;
                        },
                    ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Ex: Semua perlu waktu",
                            labelText: "Title",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                        ),
                        // Menambahkan behavior saat nama diketik 
                        onChanged: (String? value) {
                            setState(() {
                                _title = value!;
                            });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                            setState(() {
                                _title = value!;
                            });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return 'Judul tidak boleh kosong!';
                            }
                            return null;
                        },
                    ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Write your happy thoughts",
                            labelText: "Notes",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                        ),
                        // Menambahkan behavior saat nama diketik 
                        onChanged: (String? value) {
                            setState(() {
                                _notes = value!;
                            });
                        },
                        // Menambahkan behavior saat data disimpan
                        onSaved: (String? value) {
                            setState(() {
                                _notes = value!;
                            });
                        },
                        // Validator sebagai validasi form
                        validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return 'Judul tidak boleh kosong!';
                            }
                            return null;
                        },
                    ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                      child: const Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () async {
                        await request.postJson(
                          "https://joyfultimes.up.railway.app/newNotes/createfromflutter/",
                          convert.jsonEncode(<String, String>{
                            'sender': _sender,
                            'title' : _title,
                            'notes' : _notes,
                          })
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notes()),
                        );

                        
                    }),
                      ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        
                        child:TextButton(
                          
                      child: const Text(
                        "Go Back",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () {
                        
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notes()),
                        );
                        
                      },
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