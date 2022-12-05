import 'package:joyfultimes/drawer.dart';
import 'package:joyfultimes/forumpost.dart';
import 'package:flutter/material.dart';
import 'package:joyfultimes/forum.dart';

class ForumPostDetail extends StatefulWidget {
  const ForumPostDetail({super.key, required this.myForum});
  final ForumPost myForum;
  @override
  State<ForumPostDetail> createState() => _ForumPostDetailState();
}

class _ForumPostDetailState extends State<ForumPostDetail> {
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
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
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
            ],
          )),
    );
  }
}
