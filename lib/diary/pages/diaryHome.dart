import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/diary/fetch.dart';
import 'package:joyfultimes/auth/loginpage.dart';
import 'package:joyfultimes/diary/pages/diaryForm.dart';
import 'package:joyfultimes/diary/pages/diaryDetail.dart';

import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class DiaryHome extends StatefulWidget {
  const DiaryHome({super.key});

  @override
  State<DiaryHome> createState() => _DiaryHomeState();
}

String convertedDateTime(s) {
  var covertedHour = (s.hour + 7) > 23 ? (s.hour + 7) - 24 : (s.hour + 7);
  return "${s.year.toString()}-${s.month.toString().padLeft(2, '0')}-${s.day.toString().padLeft(2, '0')} at ${covertedHour.toString().padLeft(2, '0')}:${s.minute.toString().padLeft(2, '0')} WIB";
}

class _DiaryHomeState extends State<DiaryHome> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if (!request.loggedIn) {
      print("Cannot load diary! You must login first!");
      return Scaffold(
        appBar: AppBar(
          title: const Text("Diary | JoyfulTimes"),
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
          title: const Text("Diary | JoyfulTimes"),
        ),
        drawer: const MyDrawer(),
        body: FutureBuilder(
            future: fetchToDo(request),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Tidak ada diary.",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DiaryDetail(
                                      diaryItems: snapshot.data![index],
                                    ),
                                  ));
                            },
                            child: Container(
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
                              child: Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snapshot.data![index].fields.title}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "${snapshot.data![index].fields.body}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0.0, 10.0, 0.0, 0.0),
                                          child: RichText(
                                              text: TextSpan(
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                const TextSpan(
                                                    text: 'Last updated on: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text: convertedDateTime(
                                                        snapshot.data![index]
                                                            .fields.date))
                                              ])),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                }
              }
            }),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DiaryForm()))
                },
                tooltip: 'Add new diary',
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      );
      //
    }
    ;
  }
}
