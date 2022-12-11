import 'package:joyfultimes/forum/models/forumpost.dart';
import 'package:joyfultimes/forum/pages/forum.dart';
import 'package:joyfultimes/main.dart';
import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/forum/models/forumpost.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:joyfultimes/main.dart';

class ForumForm extends StatefulWidget {
  const ForumForm({super.key});
  @override
  State<ForumForm> createState() => _ForumFormState();
}

class _ForumFormState extends State<ForumForm> {
  final _formKey = GlobalKey<FormState>();
  String topic = "";
  DateTime? date = DateTime.now();
  String description = "";
  String role = 'Patient';
  List<String> listRole = ['Patient', 'Experts', 'Clinical', 'Patient\'s Relative'];
  void _initSubmitForum(request) async {
    final response = await request
        .post(
        "https://joyfultimes.up.railway.app/forum/flutter/addForum/", {
      'topic': topic,
      'description': description,
      'role':role,
    }).then((value) {
      final newValue = new Map<String, dynamic>.from(value);
      setState(() {
        if (newValue['status'].toString() == "success") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Success add forum!"),
            backgroundColor: Colors.green,
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Forum()),
          );
        } else
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
            Text("Failed add forum"),
            backgroundColor: Colors.red,
          ));
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Comment'),
      ),
      drawer: const MyDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter your topic",
                      labelText: "Topic",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.description),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        topic = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        topic = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Topic cannot be empty!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter your description",
                      labelText: "Description",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.title),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    minLines: 10,
                    maxLines: 20,
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        description = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        description = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Topic cannot be empty!';
                      }
                      return null;
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.class_),
                  title: const Text(
                    'Role',
                  ),
                  trailing: DropdownButton(
                    value: role,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: listRole.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        role = newValue!;
                      });
                    },
                  ),
                ),
                TextButton(
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _initSubmitForum(request);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}