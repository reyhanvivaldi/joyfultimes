import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:joyfultimes/auth/loginpage.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/assessment/model/result.dart';
import 'package:joyfultimes/assessment/pages/assessment_main.dart';

class StressAssesment extends StatefulWidget {
  const StressAssesment({super.key});

  @override
  State<StressAssesment> createState() => _StressAssesmentState();
}

class _StressAssesmentState extends State<StressAssesment> with RouteAware {

    List<String> questions = [
    "I have found myself getting upset by quite trivial things",
    "I have experienced breathing difficulties",
    "I tend to overreact to situations",
    "I have felt shakey like my legs are going to give way",
    "I have found myself getting upset easily",
    "I have found myself getting impatient when I have been delayed in any way",
    "I have experienced sweaty palms or perspiration for no physical reasons",
    "I have felt scared or nervous for no good reason",
    "I have had a sense of nervous tension, like being on edge all the time",
    "It has been difficult for me to tolerate interruptions to what I was doing"
  ];

  List<Map<String, Object>> choices = [
    {
      'text': 'Never',
      'score': 0,
    },
    {
      'text': 'Sometimes',
      'score': 1,
    },
    {
      'text': 'Often',
      'score': 2,
    },
    {
      'text': 'Very Often',
      'score': 3,
    },
  ];

  late List<double> scores = [for (var i = 0; i < questions.length; i++) 0];

  String get resultText {
    String resultText;
    int totalScore = scores.sum as int;
    if (totalScore >= 20) {
      resultText = 'High Stress Level';
    } else if (totalScore >= 15) {
      resultText = 'Moderate Stress Level';
    } else if (totalScore >= 10) {
      resultText = 'Mild Stress Level';
    } else if (totalScore >= 5) {
      resultText = 'Little Stress Level';
    } else {
      resultText = 'No Stress';
    }
    return resultText;
  }

  @override
  void initState() {
    showResult();
    super.initState();
  }

  showResult() async {
    final request = context.read<CookieRequest>();
    String url = 'https://joyfultimes.up.railway.app/assessment/fetch-stress-result-flutter/';
    Result data;

    final response = await request.get(url);
    data = Result.fromMap(response);
    
    if (data.result != "") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Last Stress Assessment Result",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              "${data.result} (${data.date.toLocal().toString().substring(0, 16)})",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stress Assessment'),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Center(
                  child: Text(
                    'In the last 2 weeks, how often are you bothered by the following problems?',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              for (int i = 0; i < questions.length; i++)
              Column(
                children: [
                  const Divider(
                    thickness: 2.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(questions[i]),
                  ),
                  Slider(
                    value: scores[i],
                    min: 0,
                    max: 3,
                    divisions: 3,
                    label: '${choices[scores[i].round()]['text']}',
                    onChanged: (value) {
                      setState(() {
                        scores[i] = value;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new ElevatedButton(
                      child: const Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Assesment()),
                        );
                      },
                    ),
                    new ElevatedButton(
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "Assessment Result",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                resultText,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            );
                          },
                        );
                        await request.postJson(
                          "https://joyfultimes.up.railway.app/assessment/add-stress-result-flutter/",
                          convert.jsonEncode(<String, String>{
                            'result': resultText,
                          })
                        );
                      },
                    ),
                  ]
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}