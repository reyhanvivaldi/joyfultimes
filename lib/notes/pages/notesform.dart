import 'package:flutter/material.dart';
import 'package:joyfultimes/notes/pages/notes.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/notes/utils/fetchnotes.dart';
import 'package:joyfultimes/notes/model/notesmodel.dart';
import 'package:joyfultimes/notes/pages/notesform.dart';
import 'package:joyfultimes/notes/pages/notesuser.dart';
import 'dart:convert';
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
                            hintText: "Contoh: Sate Pacil",
                            labelText: "Judul",
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
                            hintText: "Contoh: Sate Pacil",
                            labelText: "Judul",
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
                            hintText: "Contoh: Sate Pacil",
                            labelText: "Judul",
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
                    TextButton(
                      child: const Text(
                        "Send",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState!.validate()){
                          var item = {
                            'sender' : _sender,
                            'title' : _title,
                            'notes' : _notes
                          };
                          final response = await request.post(
                            "https://joyfultimes.up.railway.app/newNotes/createfromflutter", item);

                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Notes Sent!"),
                          ));

                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notes()),
                        );
                        } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Sorry, there's an error occured!"),
                        ));
                        }
                      }
                    }),
                     TextButton(
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
                    ],
                  ),
                ),
                ),
          ),
    );
  }
}