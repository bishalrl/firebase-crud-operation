import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

// SignUpUser(String userName, String userEmail, String userPassword) async {
//   User? userid = FirebaseAuth.instance.currentUser;

//   try {
//     if (userid != null) {
//       await FirebaseFirestore.instance.collection("user").doc(userid.uid).set({
//         "userName": userName,
//         "userEmail": userEmail,
//         "userPassword": userPassword,
//         "createdAt": DateTime.now(),
//         "uid": userid,
//       });
//     }
//   } on FirebaseAuthException catch (e) {
//     print("error on $e");
//   }
// }
SignUpUser(String userName, String userEmail, String userPassword) async {
  User? user = FirebaseAuth.instance.currentUser;

  try {
    if (user != null) {
      String uid = user.uid;

      await FirebaseFirestore.instance.collection("user").doc(uid).set({
        "userName": userName,
        "userEmail": userEmail,
        "userPassword": userPassword,
        "createdAt": DateTime.now(),
        "uid": uid,
      });
    }
  } on FirebaseAuthException catch (e) {
    print("error $e");
  }
}
