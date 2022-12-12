import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/notes/utils/fetchnotes.dart';
import 'package:joyfultimes/notes/model/notesmodel.dart';
import 'package:joyfultimes/notes/pages/notesform.dart';
import 'package:joyfultimes/notes/pages/notesuser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';



class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final Future<List<NotesModel>> future = fetchNotes();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Notes | JoyfulTimes"),
      ),
      drawer: const MyDrawer(),
      // body
              body: Column (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Send notes to people in need",
                  style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  FutureBuilder<List<NotesModel>>(
                    future: future,
                    builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        if (!snapshot.hasData) {
                          return Column(
                            children: [
                              Text(
                                "Oh no! Tidak ada watch list :(",
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        } else {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => InkWell(
                                // make anything clickable
                                onTap: () {
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                      
                                  // );
                                }
                                ,
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    padding: const EdgeInsets.all(20.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(17.0),
                                    ),
                                    child: Column(
                                      
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                            Text(snapshot.data![index].fields.title,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              snapshot.data![index].fields.notes,
                                              overflow: TextOverflow.fade,
                                            ),
                                            Text("-" + snapshot.data![index].fields.sender),
                                        ])),
                              ));
                        }
                      }
                    },
                  ),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotesForm())
                        );
                      },
                      child: const SizedBox(
                          height: 40,
                          width: 200,
                          child: Center(
                            child: Text(
                              "Add New Notes",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                      )
                  ),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotesUser())
                        );
                      },
                      child: const SizedBox(
                          height: 40,
                          width: 200,
                          child: Center(
                            child: Text(
                              "See my notes",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                      )
                  ),
                ],)
              
             
    ); // scaffold
  }
}