import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/forum/models/forumpost.dart';
import 'package:flutter/material.dart';
import 'package:joyfultimes/forum/pages/forum.dart';
import 'package:joyfultimes/forum/models/comment.dart';
import 'package:joyfultimes/forum/utils/fetchComment.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:joyfultimes/forum/pages/commentform.dart';

class ForumPostDetail extends StatefulWidget {
  const ForumPostDetail({super.key, required this.myForum});
  final ForumPost myForum;
  @override
  State<ForumPostDetail> createState() => _ForumPostDetailState();
}

class _ForumPostDetailState extends State<ForumPostDetail> {

  @override
  Widget build(BuildContext context) {

    final Future<List<Comment>> future = fetchComment(widget.myForum.pk);
    final request = context.watch<CookieRequest>();
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
                if (request.loggedIn)
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentForm(myForum:widget.myForum)),
                        );
                      },
                      child: const SizedBox(
                          height: 40,
                          width: 200,
                          child: Center(
                            child: Text(
                              "Add New Comment",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                      )
                  ),
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
                          shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (_, index) => Container(
                                  padding: const EdgeInsets.all(20.0),
                                  height:150,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo,
                                    borderRadius: BorderRadius.circular(17.0),
                                  ),
                                  child: Padding(
                                      padding:const EdgeInsets.all(8.0),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
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
                                          ])
                                  )
                                  ),
                            );
                      }
                    }
                  },
                )
              ]),

            ],
          ),
      ),
    );
  }
}
