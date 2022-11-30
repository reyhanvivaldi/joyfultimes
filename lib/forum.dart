
import 'package:flutter/material.dart';
import 'package:joyfultimes/drawer.dart';


class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Forum | JoyfulTimes"),
      ),
      drawer: const MyDrawer(),
    ); // scaffold
  }
}