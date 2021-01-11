import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbOperations {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference usersDB =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser(User currentUser) async {
    DocumentSnapshot docSnapshot = await usersDB.doc(currentUser.uid).get();
    if (!docSnapshot.exists) {
      var userData = {
        'email': currentUser.email,
        'name': currentUser.displayName,
        'photo': currentUser.photoURL
      };
      return usersDB
          .doc(currentUser.uid)
          .set(userData)
          .then((value) => print("user added"))
          .catchError((error) => print("Error occured: $error"));
    }
    print('user already exists');
  }
}
