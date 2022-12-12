import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:joyfultimes/auth/loginpage.dart';
import 'dart:convert';
import 'package:joyfultimes/mood-tracker/model/mood.dart';
import 'package:joyfultimes/mood-tracker/pages/form_mood.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Mood>> fetchMood(request) async {
    var response =
        await request.get("https://joyfultimes.up.railway.app/cal/event/json");
    // print(response[0]);
    // melakukan konversi data json menjadi object ToDo
    List<Mood> listMood = [];
    for (var d in response) {
      if (d != null) {
        var newmod = Mood.fromJson(d);
        listMood.add(newmod);
      }
    }

    return listMood;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    if (!request.loggedIn) {
      print("Cannot load mood tracker! You must login first!");
      return Scaffold(
        appBar: AppBar(
          title: const Text("Mood Tracker | JoyfulTimes"),
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
          backgroundColor: Color.fromARGB(171, 63, 81, 181),
          // floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
          floatingActionButton: FloatingActionButton(
            child: const Text('Add'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyFormPage()),
              );
            },
          ),
          appBar: AppBar(
            title: const Text('Mood Tracker | JoyfulTimes'),
          ),
          drawer: const MyDrawer(),
          body: FutureBuilder(
              future: fetchMood(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return Column(
                      children: const [
                        Text(
                          "Tidak ada record :(",
                          style:
                              TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 2.0)
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${snapshot.data![index].fields.mood}",
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                      "Score: ${snapshot.data![index].fields.range}"),
                                  Text(
                                      "${snapshot.data![index].fields.deskripsi}"),
                                  Text(
                                      "${snapshot.data![index].fields.dateTime}"),
                                ],
                              ),
                            ));
                  }
                }
              }));
    }
  }
}
