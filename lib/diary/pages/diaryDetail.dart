import 'package:flutter/material.dart';
import 'package:joyfultimes/diary/model/model.dart';
import 'package:joyfultimes/widgets/drawer.dart';

class DiaryDetail extends StatefulWidget {
  const DiaryDetail({super.key, required this.diaryItems});
  final Diary diaryItems;

  @override
  State<DiaryDetail> createState() => _DiaryDetailState();
}

class _DiaryDetailState extends State<DiaryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Flexible(
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
                    ),
                    Row(
                      children: [
                        const Text("Last updated on: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            )),
                        Text("${widget.diaryItems.fields.date}",
                            style: const TextStyle(
                              fontSize: 16,
                            ))
                      ],
                    ),
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
              ),
              ElevatedButton(
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
            ],
          ),
        ));
  }
}
