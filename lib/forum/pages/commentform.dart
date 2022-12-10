import 'package:joyfultimes/forum/models/forumpost.dart';
import 'package:joyfultimes/main.dart';
import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/forum/models/forumpost.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({super.key, required this.myForum});
  final ForumPost myForum;
  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _formKey = GlobalKey<FormState>();
  String _topic = "";
  DateTime? _date = DateTime.now();
  String _description = "";
  String role = 'Patient';
  List<String> listRole = ['Patient', 'Experts', 'Clinical', 'Patient\'s Relative'];

  @override
  Widget build(BuildContext context) {
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
                      hintText: "Enter your comment",
                      labelText: "Comment",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.description),
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
                        _topic = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _topic = value!;
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