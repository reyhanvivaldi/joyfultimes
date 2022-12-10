import 'package:flutter/material.dart';
import 'package:joyfultimes/widgets/drawer.dart';
import 'package:joyfultimes/auth/signup.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String username = "";
  String password1 = "";
  String statusMessage = "";
  void _initLogin(request) async {
    final response = await request.login("https://joyfultimes.railway.app/auth/loginFlutter/", {
      'username': username,
      'password': password1,
    });
    if (request.loggedIn) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login success!"),
      ));
      Navigator.pushReplacementNamed(context, '/main');
    }
  }
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: const MyDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _loginFormKey,
                child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "Login to JoyfulTimes",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Color.fromARGB(178, 3, 3, 3)),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Username ",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                  setState(() {
                                    username = value!;
                                  });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                  setState(() {
                                    username = value!;
                                  });
                                },
                                // Validator sebagai validasi form
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill out this field.";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              // Menggunakan padding sebesar 8 pixels
                              padding: const EdgeInsets.all(8.0),

                              child: TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password ",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                // Menambahkan behavior saat nama diketik
                                onChanged: (String? value) {
                                  setState(() {
                                    password1 = value!;
                                  });
                                },
                                // Menambahkan behavior saat data disimpan
                                onSaved: (String? value) {
                                  setState(() {
                                    password1 = value!;
                                  });
                                },
                                // Validator sebagai validasi form
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please fill out this field.";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              width: double.infinity,
                              child: ElevatedButton(
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(14))),
                                    backgroundColor:
                                    MaterialStateProperty.all(Colors.indigo),
                                  ),
                                  onPressed: () {
                                    if (_loginFormKey.currentState!.validate()) {
                                      _initLogin(request);
                                    }
                                  }),
                            ),
                            Text(statusMessage),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUpPage()),
                                );
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ]),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}