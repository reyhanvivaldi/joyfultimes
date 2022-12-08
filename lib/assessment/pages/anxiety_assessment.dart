import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/assessment/model/result.dart';

class AnxietyAssesment extends StatefulWidget {
  const AnxietyAssesment({super.key});

  @override
  State<AnxietyAssesment> createState() => _AnxietyAssesmentState();
}

class _AnxietyAssesmentState extends State<AnxietyAssesment> with RouteAware {

    List<String> questions = [
    "I find it very hard to unwind, relax or sit still",
    "I have had stomach problems, such as feeling sick or stomach cramps",
    "I have been irritable and easily become annoyed",
    "I have experienced shortness of breath",
    "I have felt dizzy and unsteady at times",
    "I have had difficulties with sleep (including waking early, finding it hard to go to sleep)",
    "I have felt panicked and overwhelmed by things in my life",
    "I have felt nervous and on edge",
    "I have had trembling hands",
    "I seem to be constantly worrying about things"
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
      resultText = 'High Anxiety Level';
    } else if (totalScore >= 15) {
      resultText = 'Moderate Anxiety Level';
    } else if (totalScore >= 10) {
      resultText = 'Mild Anxiety Level';
    } else if (totalScore >= 5) {
      resultText = 'Little Anxiety Level';
    } else {
      resultText = 'No Anxiety';
    }
    return resultText;
  }

  @override
  void initState() {
    showResult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<NetworkService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anxiety Assessment'),
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
                child: Text(
                  'In the last 2 weeks, how often are you bothered by the following problems?',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
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
                child: TextButton(
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF0B36A8)),
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                              "Assessment Result"),
                          content: Text(resultText),
                        );
                      },
                    );
                    await request.postJson(
                        "https://joyfultimes.up.railway.app/assessment/add-anxiety-result-flutter/",
                        convert.jsonEncode(<String, String>{
                          'result': resultText,
                        })
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showResult() async {
    final request = context.read<NetworkService>();
    String url = 'https://joyfultimes.up.railway.app/assessment/fetch-anxiety-result-flutter/';
    Result data;

    final response = await request.get(url);
    data = Result.fromMap(response);
    
    if (data.result != "") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Last Anxiety Assessment Result"),
            content: Text("${data.result} (${data.date.toLocal().toString().substring(0, 16)})"),
          );
        },
      );
    }
  }
}