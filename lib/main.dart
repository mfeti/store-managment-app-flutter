import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store_management/models/wrapper.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "apikey",
            appId: "appId",
            messagingSenderId: "messagingSenderId",
            projectId: "projectId"));
  }
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    title: 'Store Management',
    home: Wrapper(),
  ));
}
