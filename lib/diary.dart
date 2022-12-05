import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';

class Diary extends StatefulWidget {
  const Diary({super.key});

  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Diary | JoyfulTimes"),
      ),
      drawer: const MyDrawer(),
    ); // scaffold
  }
}
