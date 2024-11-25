// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:store_management/models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:store_management/models/user.dart';
// import 'package:store_management/models/user.dart';

class FireStore {
  final db = FirebaseFirestore.instance;

  getUserData(String uid) {
    final docRef = db.collection("Users").doc(uid);
    try {
      return docRef.snapshots();
    } catch (e) {
      print("Error getting document: $e");
    }
  }

  updateItemData(String name, String catagory, String quantity,
      String measurments, String? localLocation) async {
    //, String departure,String destination, String date, String seatNo, String price) async {
    Map<String, Object> items = {
      'catagory': catagory,
      'name': name,
      'quantity': quantity,
      'measurements': measurments,
      'localArea': localLocation ?? ""
    };
    DocumentReference document = await db.collection('Items').add(items);
    return document.id.toString();
  }

  getItems() {
    final docRef = db.collection('Items');
    return docRef.snapshots();
  }
}
