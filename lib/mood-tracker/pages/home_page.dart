import 'package:flutter/material.dart';
// import 'package:joyfultimes/mood-tracker/components/habit_tile.dart';
// import 'package:joyfultimes/mood-tracker/components/month_summary.dart';
// import 'package:joyfultimes/mood-tracker/components/my_fab.dart';
// import 'package:joyfultimes/mood-tracker/components/my_alert_box.dart';
// import 'package:joyfultimes/mood-tracker/data/habit_database.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:joyfultimes/mood-tracker/pages/form_mood.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(171, 63, 81, 181),
      // floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyFormPage()),
            );
          },
        ),
      ),
    );

    // list of habits
    // ListView.builder(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   itemCount: db.todaysHabitList.length,
    //   itemBuilder: (context, index) {
    //     // return HabitTile(
    //     //   habitName: db.todaysHabitList[index][0],
    //     //   habitCompleted: db.todaysHabitList[index][1],
    //     //   onChanged: (value) => checkBoxTapped(value, index),
    //     //   // settingsTapped: (context) => openHabitSettings(index),
    //     //   // deleteTapped: (context) => deleteHabit(index),
    //     );
    //   },
    // )
    //     ],
    //   ),
    // );
  }
}
