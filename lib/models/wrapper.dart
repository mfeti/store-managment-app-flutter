import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_management/models/firestore.dart';
// import 'package:store_management/models/firestore.dart';
import 'package:store_management/screens/login.dart';
import 'package:store_management/screens/home.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Widget state = const Login();
  final firestore = FireStore();
  String name = '';
  getUserData(user) {
    name = firestore.getUserData(user.uid);
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // setState(() {
      //   if (user != null) {
      //     state = Home(
      //       email: user.email!,
      //       name: getUserData(user),
      //       isManager: false,
      //     );
      setState(() {
        if (user != null) {
          state = Home(
            uid: user.uid,
          );
        } else {
          state = const Login();
        }
      });
    });

    // return StreamBuilder<User?>(
    //   stream: FirebaseAuth.instance.authStateChanges().asBroadcastStream(),
    //   builder: (context, user) {

    return state;
    // }
    // );
    // return const Home();
  }
}
