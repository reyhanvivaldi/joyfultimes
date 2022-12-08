import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/assessment/model/result.dart';

class Assesment extends StatefulWidget {
  const Assesment({super.key});

  @override
  State<Assesment> createState() => _AssesmentState();
}

class _ForumState extends State<Forum> {
  final Future<List<ForumPost>> future = fetchForumPost();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Assessment | JoyfulTimes"),
      ),
      drawer: const MyDrawer(),
    );
  }
}