import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:joyfultimes/auth/loginpage.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/assessment/model/result.dart';
import 'package:joyfultimes/assessment/pages/assessment_main.dart';

class DepressionAssesment extends StatefulWidget {
  const DepressionAssesment({super.key});

  @override
  State<DepressionAssesment> createState() => _DepressionAssesmentState();
}

class _DepressionAssesmentState extends State<DepressionAssesment> with RouteAware {

    List<String> questions = [
    "I feel overwhelmingly sad at times",
    "When I think of the future I feel hopeless",
    "I feel like a complete failure",
    "I feel guilty about something most of the time",
    "I feel like I am being punished",
    "I feel disappointed (even disgusted) with myself",
    "I am often on the brink of tears or just want to cry",
    "I am so tired I don't have the energy to do anything",
    "My sleep patterns have been really disrupted",
    "I find it really hard to do anything, especially work"
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
      resultText = 'High Depression Level';
    } else if (totalScore >= 15) {
      resultText = 'Moderate Depression Level';
    } else if (totalScore >= 10) {
      resultText = 'Mild Depression Level';
    } else if (totalScore >= 5) {
      resultText = 'Little Depression Level';
    } else {
      resultText = 'No Depression';
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
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Depression Assessment'),
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
                        "https://joyfultimes.up.railway.app/assessment/add-depression-result-flutter/",
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
    final request = context.watch<CookieRequest>();
    String url = 'https://joyfultimes.up.railway.app/assessment/fetch-depression-result-flutter/';
    Result data;

    final response = await request.get(url);
    data = Result.fromMap(response);
    
    if (data.result != "") {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Last Depression Assessment Result"),
            content: Text("${data.result} (${data.date.toLocal().toString().substring(0, 16)})"),
          );
        },
      );
    }
  }
}