import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/login/login.dart';
import 'package:flutter_application_2/serveces/signupservice.dart';

import '../login/MainTextfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller =
      TextEditingController(text: '');
  final TextEditingController _phonecontroller =
      TextEditingController(text: '');
  final TextEditingController _usernamecontroller =
      TextEditingController(text: '');
  User? currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" Signup Screen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MainTextField(
              hinttext: 'email ',
              iconn: Icons.email,
              textEditingController: _emailcontroller),
          const SizedBox(
            height: 20,
          ),
          MainTextField(
              hinttext: 'enter your name',
              iconn: Icons.person,
              textEditingController: _usernamecontroller),
          const SizedBox(
            height: 20,
          ),
          MainTextField(
              hinttext: 'enter the password',
              iconn: Icons.password,
              textEditingController: _passwordcontroller),
          const SizedBox(
            height: 20,
          ),
          MainTextField(
              hinttext: 'phonenumber',
              iconn: Icons.phone,
              textEditingController: _phonecontroller),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () async {
              var userName =
                  _usernamecontroller.text.toString().trim().toLowerCase();
              var userEmail =
                  _emailcontroller.text.toLowerCase().toString().trim();
              var userPassword =
                  _passwordcontroller.text.toString().trim().toLowerCase();
              await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: userEmail, password: userPassword)
                  .then((value) => {
                        SignUpUser(userName, userEmail, userPassword),
                        log('user stored')
                      });
            },
            child: const Text('signup'),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: const Text("Already have account ? Login"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreem()));
            },
          )
        ],
      ),
    );
  }
}
