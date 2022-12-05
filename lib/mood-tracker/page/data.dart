import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/mood-tracker/model/mood.dart';

class Mood extends StatefulWidget {
  const Mood({super.key});

  @override
  State<Mood> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<Mood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Mood'),
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: Budget.budgets.map((budget) {
                return Card(
                  child: ListTile(
                      title: Text("${budget.judul}\n${budget.nominal}"),
                      subtitle: Text(budget.date.toString().split(' ')[0]),
                      trailing: Text(budget.tipe)),
                );
              }).toList(),
            ),
          ),
        ));
  }
}
