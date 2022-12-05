import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/notes/pages/fetchnotes.dart';
import 'package:joyfultimes/notes/model/notesmodel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



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
              body: FutureBuilder<List<NotesModel>>(
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
                          child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(snapshot.data![index].fields.sender),
                                Text(
                                    snapshot.data![index].fields.notes,
                                    overflow: TextOverflow.fade,
                                  ),
                              ])),
                    ));
              }
            }
          },
        )
    ); // scaffold
  }
}