import 'package:joyfultimes/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _deskripsi = "";
  String mood = 'Happy';
  List<String> listmood = [
    'Happy',
    'Sad',
    'Angry',
    'Blessed',
    'Stressed',
    'Bored',
    'Crazy'
  ];
  // double _currentSliderValue = 20;
  DateTime dateTime = DateTime(2022, 12, 09, 23, 14);
  DateTime dateTime1 = DateTime(2022, 12, 09, 23, 14);
  TextEditingController timeinput = TextEditingController();
  double _value = 20;
  String _status = 'idle';
  Color _statusColor = Colors.amber;
  @override
  Widget build(BuildContext context) {
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    final hours1 = dateTime.hour.toString().padLeft(2, '0');
    final minutes1 = dateTime.minute.toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        title: Text('Form'),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.class_),
                  title: const Text(
                    'Mood',
                  ),
                  trailing: DropdownButton(
                    value: mood,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: listmood.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        mood = newValue!;
                      });
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Aku pergi berlibur",
                      labelText: "Deskripsi",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.people),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _deskripsi = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _deskripsi = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Slider(
                  min: 0.0,
                  max: 100.0,
                  value: _value,
                  divisions: 10,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                      _status = 'active (${_value.round()})';
                      _statusColor = Colors.green;
                    });
                  },
                  onChangeStart: (value) {
                    setState(() {
                      _status = 'start';
                      _statusColor = Colors.lightGreen;
                    });
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      _status = 'end';
                      _statusColor = Colors.red;
                    });
                  },
                ),
                Text(
                  'Status: $_status',
                  style: TextStyle(color: _statusColor),
                ),
                ElevatedButton(
                    onPressed: pickDateTime,
                    child: Text(
                        '${dateTime.year}/${dateTime.month}/${dateTime.day} $hours:$minutes')),
                ElevatedButton(
                    onPressed: pickDateTime1,
                    child: Text(
                        '${dateTime1.year}/${dateTime1.month}/${dateTime1.day} $hours1:$minutes1')),
              ],
            ),
          ))),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() => this.dateTime = dateTime);
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );

  Future pickDateTime1() async {
    DateTime? date1 = await pickDate1();
    if (date1 == null) return;

    TimeOfDay? time1 = await pickTime1();
    if (time1 == null) return;

    final dateTime1 = DateTime(
      date1.year,
      date1.month,
      date1.day,
      time1.hour,
      time1.minute,
    );
    setState(() => this.dateTime1 = dateTime1);
  }

  Future<DateTime?> pickDate1() => showDatePicker(
        context: context,
        initialDate: dateTime1,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
  Future<TimeOfDay?> pickTime1() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime1.hour, minute: dateTime1.minute),
      );
}
