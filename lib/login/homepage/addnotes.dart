import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/login/button.dart';

import '../MainTextfield.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final TextEditingController _notescontroller =
      TextEditingController(text: '');
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Notes")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 100),
        child: Column(
          children: [
            MainTextField(
                hinttext: 'add notes',
                iconn: Icons.add,
                textEditingController: _notescontroller),
            SizedBox(
              height: 50,
            ),
            ButtonB(
                nameofbutton: 'Add Notes',
                ontap: () async {
                  try {
                    var note = _notescontroller.text.trim().toString();

                    if (note != null) {
                      await FirebaseFirestore.instance
                          .collection('N0tes')
                          .doc()
                          .set({
                        'createdAt': DateTime.now(),
                        'Note': note,
                        'userId': user!.uid,
                      });
                    } else
                      print('entersomething');
                  } catch (e) {
                    print('error on$e');
                  }
                },
                colorofbutton: Colors.blueAccent,
                heightofbutton: 40,
                widthofbutton: 160)
          ],
          // mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
