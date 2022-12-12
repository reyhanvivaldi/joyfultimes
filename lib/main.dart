import 'dart:io';

import 'package:flutter/material.dart';
import 'package:joyfultimes/auth/fetchuserloggedin.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:joyfultimes/auth/userloggedin.dart';

Future<void> main() async {
  await Hive.initFlutter();

  // open a box
  await Hive.openBox("Habit_Database");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'JoyfulTimes',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title = "Home";

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Ini bikin eror, dan datanya redundant.. jadi gue comment aja ya
    // final Future<List<LoggedIn>> future = fetchUserLoggedIn();
    // final request = context.watch<CookieRequest>();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        drawer: const MyDrawer(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: Image.file(
                //           File('assets/bg.png'),
                //           fit: BoxFit.cover,
                //         )
                //       ),
                //   ),
                // ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                  child: Text("Welcome to JoyfulTimes!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                ),
                const Text(
                  "Meet our Team",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Image.asset(
                  'assets/images/naz.jpg',
                  width: 200,
                  height: 250,
                ),
                const Text(
                  "Naznien Fevrianne Malano",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Image.asset(
                  'assets/images/alia.jpg',
                  width: 200,
                  height: 250,
                ),
                const Text(
                  "Alia Widyanita Puspaningrum",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Image.asset(
                  'assets/images/alif.jpg',
                  width: 200,
                  height: 250,
                ),
                const Text(
                  "Muhammad Alif Ismady",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Image.asset(
                  'assets/images/prita.jpg',
                  width: 200,
                  height: 250,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                  child: const Text(
                    "Prita Elisabeth Laura Tarigan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Image.asset(
                  'assets/images/rey.jpg',
                  width: 200,
                  height: 250,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
                  child: Text(
                    "Reyhan Vivaldi Adrian",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        )

        // Center(
        //   // Center is a layout widget. It takes a single child and positions it
        //   // in the middle of the parent.
        //   child: Column(
        //     // Column is also a layout widget. It takes a list of children and
        //     // arranges them vertically. By default, it sizes itself to fit its
        //     // children horizontally, and tries to be as tall as its parent.
        //     //
        //     // Invoke "debug painting" (press "p" in the console, choose the
        //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
        //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        //     // to see the wireframe for each widget.
        //     //
        //     // Column has various properties to control how it sizes itself and
        //     // how it positions its children. Here we use mainAxisAlignment to
        //     // center the children vertically; the main axis here is the vertical
        //     // axis because Columns are vertical (the cross axis would be
        //     // horizontal).
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: <Widget>[
        //       Text("It's time to talk with people who will support you.",
        //       style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
        //       ),
        //       Text("We are a friendly, safe community supporting each other's mental health 24 hours a day, 365 days a year. You are most welcome to join today!")

        //     ],
        //   ),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
