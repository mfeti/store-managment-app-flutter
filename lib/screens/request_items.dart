import 'package:flutter/material.dart';

class RequestItems extends StatefulWidget {
  const RequestItems({super.key});

  @override
  State<RequestItems> createState() => _RequestItemsState();
}

class _RequestItemsState extends State<RequestItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('request items'),
        backgroundColor: Colors.blueGrey[600],
        elevation: 0.0,
      ),
      body: const Center(child: Text('request items')),
    );
  }
}
