import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/login/button.dart';
import 'package:image_picker/image_picker.dart';

class AddPhoto extends StatefulWidget {
  const AddPhoto({super.key});

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  var imageurl = '';
  var image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundImage: image == null
                  ? NetworkImage(
                      'https://imgs.search.brave.com/sSUhxZErbj4ES1E0Ld6DfJ1svu5JKSFpC8nl-EuXkZ8/rs:fit:518:225:1/g:ce/aHR0cHM6Ly90c2Ux/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5D/aWxJZDM3NGVTRl9u/T2kwbzB0TWNRSGFH/eCZwaWQ9QXBp')
                  : NetworkImage(image),
              radius: 100,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  ImagePicker pickeimage = await ImagePicker();
                  XFile? file =
                      await pickeimage.pickImage(source: ImageSource.camera);
                  print('${file?.path}');
                  //set state for the picked image and show
                  setState(() {
                    image = file!.path;
                  });

                  //storing on storage
                  final ref = FirebaseStorage.instance
                      .ref()
                      .child('userimage')
                      .child('${DateTime.now()}');
                  await ref.putFile(File(file!.path));
                  //adding the url on local variable to store in firestore
                  imageurl = await ref.getDownloadURL();
                },
                child: Icon(Icons.camera)),
            ButtonB(
                nameofbutton: "add image",
                ontap: () async {
                  await FirebaseFirestore.instance
                      .collection('userimage')
                      .doc()
                      .set({'ImageUrl': imageurl});
                },
                colorofbutton: Color.fromARGB(255, 245, 245, 187),
                heightofbutton: 60,
                widthofbutton: 200)
          ],
        ),
      ),
    );
  }
}
