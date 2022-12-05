import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/mood-tracker/model/mood.dart';
import 'package:joyfultimes/mood-tracker/page/data.dart';
import 'package:flutter/material.dart';

class MoodTracker extends StatelessWidget {
  const MoodTracker({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Latihan Pindah Halaman"),
      ),
      body: Center(
        //membuat tombol
        child: ElevatedButton(
            //aksi yang akan dijalankan saat tombol diklik/ditekan
            onPressed: () {
              //navigator.push adalah fungsi di flutter untuk berpindah halaman
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Mood()),
              );
            },
            child: Text("klik untuk menuju ke halaman lain")),
      ),
    );
  }
}
