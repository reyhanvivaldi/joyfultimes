import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/notes/utils/fetchnotes.dart';
import 'package:joyfultimes/notes/model/notesmodel.dart';
import 'package:joyfultimes/notes/pages/notesform.dart';
import 'package:joyfultimes/notes/pages/notesuser.dart';
import 'package:joyfultimes/notes/pages/notes.dart';
import 'package:joyfultimes/notes/utils/fetchnotesuser.dart';

import 'package:joyfultimes/auth/loginpage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class NotesUser extends StatefulWidget {
  const NotesUser({super.key});

  @override
  State<NotesUser> createState() => _NotesUserState();
}

class _NotesUserState extends State<NotesUser> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if (!request.loggedIn) {
      print("Cannot load notes! You must login first!");
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
    } else {
      return Scaffold(
      appBar: AppBar(
        title: const Text ("Notes | JoyfulTimes"),
      ),
      drawer: const MyDrawer(),
      // body
              body: 
              Column (
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("This are the notes you sent..\nThankyou",
                  style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  FutureBuilder<List<NotesModel>>(
                    future: fetchUserNotes(request),
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
                                            Text(snapshot.data![index].fields.sender),
                                        ])),
                              ));
                        }
                      }
                    },
                  ),
                  Spacer(flex: 2),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notes())
                        );
                      },
                      child: const SizedBox(
                          height: 40,
                          width: 200,
                          child: Center(
                            child: Text(
                              "Go Back",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                      )
                  ),
                  
                ],)
              
             
    ); // scaffold
    }
    ;
  }
}