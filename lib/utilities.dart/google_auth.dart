import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo_app/utilities.dart/crud_db.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    GoogleSignInAccount googleAccount = await googleSignIn.signIn();
    UserCredential user;
    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuthentication =
          await googleAccount.authentication;

      GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuthentication.accessToken,
          idToken: googleAuthentication.idToken);

      user = await auth.signInWithCredential(googleCredential);

      await DbOperations().addUser(user.user);
    } else {
      print("need google account");
    }

    return user;
  }

  Future<void> signOutFromGoogle() async {
    googleSignIn.signOut();
    return auth.signOut();
  }
}
