import 'package:flutter/material.dart';
import 'package:joyfultimes/diary/model/model.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/mood-tracker/datetime/date_time.dart';
import 'package:joyfultimes/diary/pages/diaryEdit.dart';

class DiaryDetail extends StatefulWidget {
  const DiaryDetail({super.key, required this.diaryItems});
  final Diary diaryItems;

  @override
  State<DiaryDetail> createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  @override
  Widget build(BuildContext context) {
    DateTime date = widget.diaryItems.fields.date;
    var covertedHour =
        (date.hour + 14) > 23 ? (date.hour + 14) - 24 : (date.hour + 14);
    String convertedDateTime =
        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} at ${covertedHour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} WIB";

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        drawer: const MyDrawer(),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 30, top: 10),
                        child: Text(
                          widget.diaryItems.fields.title,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: [
                          const TextSpan(
                              text: 'Last updated on: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: convertedDateTime)
                        ])),
                    const Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0)),
                    Text(
                      widget.diaryItems.fields.body,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                // Error when post: Unhandled Exception: FormatException: Unexpected character (at line 2, character 1)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DiaryEdit(
                                pk: widget.diaryItems.pk,
                                diaryItems: widget.diaryItems),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    child: const Text(
                      'Edit',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                    ),
                    child: const Text(
                      'Back',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
