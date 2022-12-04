import 'package:flutter/material.dart';
import 'package:joyfultimes/loginpage.dart';
import 'package:joyfultimes/main.dart';
import 'package:joyfultimes/forum.dart';
import 'package:joyfultimes/diary.dart';
import 'package:joyfultimes/notes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Menambahkan clickable menu
          ListTile(
            title: const Text('Home'),
            onTap: () {
              // Route menu ke halaman utama
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Forum'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Forum()),
              );
            },
          ),
          ListTile(
            title: const Text('Notes'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Notes()),
              );
            },
          ),
          const ListTile(
            title: const Text('Mood Tracker'),
            // onTap: () {
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(builder: (context) => const MyWatchList()),
            //   );
            // },
          ),
          ListTile(
            title: const Text('Assesment'),
            // onTap: () {
            //   Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(builder: (context) => const MyWatchList()),
            //   );
            // },
          ),
          ListTile(
            title: const Text('Diary'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Diary()),
              );
            },
          ),
          ListTile(
            title: const Text('Login'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
