
import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/forum/utils/fetch.dart';
import 'package:joyfultimes/forum/models/forumpost.dart';
import 'package:joyfultimes/forum/pages/forumpost_detail.dart';

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
                          padding: const EdgeInsets.all(20),
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(17.0),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    snapshot.data![index].topic,
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                      snapshot.data![index].description,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      )
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                      snapshot.data![index].author,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      )
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                      snapshot.data![index].role,
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      )
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                      snapshot.data![index].dateCreated.toString(),
                                      overflow: TextOverflow.fade,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      )
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
