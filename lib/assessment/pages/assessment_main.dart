import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:joyfultimes/auth/loginpage.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/assessment/pages/depression_assessment.dart';
import 'package:joyfultimes/assessment/pages/anxiety_assessment.dart';
import 'package:joyfultimes/assessment/pages/stress_assessment.dart';

class Assesment extends StatefulWidget {
  const Assesment({super.key});

  @override
  State<Assesment> createState() => _AssesmentState();
}

class _AssesmentState extends State<Assesment> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    if (!request.loggedIn) {
      print("Cannot load assessment! You must login first!");
      return Scaffold(
        appBar: AppBar(
          title: const Text("Assessment | JoyfulTimes"),
        ),
        drawer: const MyDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: const Text(
                  "Sorry, you must login first!",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color.fromARGB(178, 3, 3, 3)
                  ),
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14))
                ),
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text(
                "Go to login page",
                style: TextStyle(color: Colors.white),
              )
            ),
          ]
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text ("Assessment | JoyfulTimes"),
        ),
        drawer: const MyDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.indigo, width: 2,),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: const Text(
                      "Depression Assesment",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color.fromARGB(178, 3, 3, 3)
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const DepressionAssesment()),
                      );
                    },
                    child: const Text(
                      "Start Test",
                      style: TextStyle(color: Colors.white),
                    )
                  ),
                ]
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.indigo, width: 2,),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: const Text(
                      "Anxiety Assesment",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color.fromARGB(178, 3, 3, 3)
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const AnxietyAssesment()),
                      );
                    },
                    child: const Text(
                      "Start Test",
                      style: TextStyle(color: Colors.white),
                    )
                  ),
                ]
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.indigo, width: 2,),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: const Text(
                      "Stress Assesment",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Color.fromARGB(178, 3, 3, 3)
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14))
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const StressAssesment()),
                      );
                    },
                    child: const Text(
                      "Start Test",
                      style: TextStyle(color: Colors.white),
                    )
                  ),
                ]
              ),
            ),
          ]
        ),
      );
    }
  }
}