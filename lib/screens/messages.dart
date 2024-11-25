import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   title: const Text('Messages'),
      //   backgroundColor: Colors.blueGrey[600],
      //   elevation: 0.0,
      // ),
      body: Center(child: Text("Messages")),
    );
  }
}
