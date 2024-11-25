import 'package:flutter/material.dart';

// import '../models/auth.dart';

class Utilized extends StatefulWidget {
  const Utilized({super.key});

  @override
  UtilizedState createState() => UtilizedState();
}

class UtilizedState extends State<Utilized> {
  // final _mAuth = Auth();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Utilize items'),
      //   backgroundColor: Colors.blueGrey[600],
      //   elevation: 0.0,
      // ),
      body: Center(child: Text("utilized")),
    );
  }
}
