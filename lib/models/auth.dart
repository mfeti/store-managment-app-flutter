import 'package:firebase_auth/firebase_auth.dart';

class Auth {
//initialize variables
  final firebase = FirebaseAuth.instance;

  status() {
    return firebase.authStateChanges().asBroadcastStream();
  }

  //sign in to firebase
  Future signIn(email, pass) async {
    try {
      final credential = await firebase.signInWithEmailAndPassword(
          email: email, password: pass);
      return credential;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future signOut() async {
    await firebase.signOut();
  }
}
