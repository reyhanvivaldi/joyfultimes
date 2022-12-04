
import 'package:flutter/material.dart';
import 'package:joyfultimes/drawer.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ("Sign Up | JoyfulTimes"),
      ),
      drawer: const MyDrawer(),
    ); // scaffold
  }
}