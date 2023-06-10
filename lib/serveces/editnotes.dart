import 'package:flutter/material.dart';
import 'package:flutter_application_2/login/MainTextfield.dart';
import 'package:flutter_application_2/login/button.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key, required});

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  final TextEditingController _updatenotecontroller =
      TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Notes')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: MainTextField(
                hinttext: 'update note',
                iconn: Icons.update,
                textEditingController: _updatenotecontroller),
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonB(
              nameofbutton: 'Update',
              ontap: () {},
              colorofbutton: Colors.blueAccent,
              heightofbutton: 35,
              widthofbutton: 150)
        ],
      ),
    );
  }
}
