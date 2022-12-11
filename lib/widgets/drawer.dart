import 'package:flutter/material.dart';
import 'package:joyfultimes/auth/loginpage.dart';
import 'package:joyfultimes/main.dart';
import 'package:joyfultimes/forum/pages/forum.dart';
import 'package:joyfultimes/diary/pages/diaryHome.dart';
import 'package:joyfultimes/notes/pages/notes.dart';
import 'package:joyfultimes/mood-tracker/pages/home_page.dart';
import 'package:joyfultimes/assessment/pages/assessment_main.dart';

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
          ListTile(
            title: const Text('Mood Tracker'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Assesment'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Assesment()),
              );
            },
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
