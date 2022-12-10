import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/assessment/model/result.dart';

class Assesment extends StatefulWidget {
  const Assesment({super.key});

  @override
  State<Assesment> createState() => _AssesmentState();
}

class _AssesmentState extends State<Assesment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Assessment | JoyfulTimes"),
      ),
      drawer: const MyDrawer(),
      body: TabBarView(
        builder: (context) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return Column(
                children: const [
                  Text(
                    "Data Kosong",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),

                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: snapshot.data![index].watched? Colors.green:Colors.red, width: 2,),
                    ),

                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                      child: ListTile(
                        title: Text(
                          "${snapshot.data![index].title}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                        ),

                        trailing: Checkbox(
                          value: snapshot.data![index].watched,
                          onChanged: (bool? newValue) {
                            setState(() {
                              snapshot.data![index].watched = !snapshot.data![index].watched;
                            });
                          }
                        ),

                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              DepressionAssesment(
                                watchList: snapshot.data![index],
                              )
                            ),
                          );
                        }
                      ),
                    ),
                  )
                ),
              );
            }
          }
        }
      )
    );
  }
}