import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/forum/models/forumpost.dart';
import 'package:flutter/material.dart';
import 'package:joyfultimes/forum/pages/forum.dart';
import 'package:joyfultimes/forum/models/comment.dart';
import 'package:joyfultimes/forum/utils/fetchComment.dart';

class ForumPostDetail extends StatefulWidget {
  const ForumPostDetail({super.key, required this.myForum});
  final ForumPost myForum;
  @override
  State<ForumPostDetail> createState() => _ForumPostDetailState();
}

class _ForumPostDetailState extends State<ForumPostDetail> {
  final Future<List<Comment>> future = fetchComment(2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      drawer: const MyDrawer(),
      body: Container(
          padding: const EdgeInsets.all(20),
          height: 800,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.myForum.topic,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '${widget.myForum.description}\n'),
                        TextSpan(
                            text: '${widget.myForum.author}\n'),
                        TextSpan(
                            text: '${widget.myForum.dateCreated}\n'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Forum()),
                      );
                    },
                    child: const SizedBox(
                        height: 40,
                        width: 200,
                        child: Center(
                          child: Text(
                            "Back",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))),
              ]),
              FutureBuilder<List<Comment>>(
                future: future,
                builder: (context, AsyncSnapshot<List<Comment>> snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData) {
                      return Column(
                        children: [
                          const Text(
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
                            // onTap: () {
                            //   Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => ForumPostDetail(
                            //             myForum:snapshot.data![index])),
                            //   );
                            // }
                            // ,
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
                                          snapshot.data![index].description,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                    ])),
                          ));
                    }
                  }
                },
              )
            ],
          ), ),

    );
  }
}
