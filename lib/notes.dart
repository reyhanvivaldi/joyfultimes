import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';


class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Notes | JoyfulTimes"),
      ),
      drawer: const MyDrawer(),
    ); // scaffold
  }
}