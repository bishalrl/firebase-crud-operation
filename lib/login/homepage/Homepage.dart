import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/components/addphoto.dart';
import 'package:flutter_application_2/login/MainTextfield.dart';
import 'package:flutter_application_2/login/button.dart';
import 'package:flutter_application_2/login/homepage/addnotes.dart';
import 'package:flutter_application_2/serveces/editnotes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          leading: GestureDetector(
            child: Icon(Icons.logout),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddPhoto()));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddNotes()));
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("N0tes")
                  .where("userId", isEqualTo: userId!.uid)
                  .snapshots(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return (const Text("Something went wrong"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CupertinoActivityIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return (const Text('No data found'));
                }

                if (snapshot != null && snapshot.data != null) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                        var note = snapshot.data!.docs[index]['Note'];
                        //  var docid = snapshot.data!.docs[index].id;

                        var id = snapshot.data!.docs[index]['userId'];
                        return Card(
                          child: ListTile(
                            title: Text(note),
                            subtitle: Text(id),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  child: Icon(Icons.edit),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditNotes(),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  child: Icon(Icons.delete),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      }));
                }
                return (Container());
              })),
        ),
      ),
    );
  }
}
