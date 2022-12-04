
import 'package:flutter/material.dart';
import 'package:joyfultimes/drawer.dart';
import 'package:joyfultimes/fetch.dart';
import 'package:joyfultimes/forumpost.dart';
import 'package:joyfultimes/forumpost_detail.dart';

class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  final Future<List<ForumPost>> future = fetchForumPost();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Forum | JoyfulTimes"),
      ),
      drawer: const MyDrawer(),
        body: FutureBuilder<List<ForumPost>>(
          future: future,
          builder: (context, AsyncSnapshot<List<ForumPost>> snapshot) {
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForumPostDetail(
                                  myForum:snapshot.data![index])),
                        );
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
                                Flexible(
                                  child: Text(
                                    snapshot.data![index].fields.topic,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ])),
                    ));
              }
            }
          },
        )
    );
  }
}
