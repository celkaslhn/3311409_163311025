import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:pro3/firebaseConfigurations.dart';

import 'ARACLAR/file.dart';

import 'ekran/login.dart';

final FirebaseConfigurations _configurations = FirebaseConfigurations();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: _configurations.apiKey,
    appId: _configurations.appId,
    messagingSenderId: _configurations.messagingSenderId,
    projectId: _configurations.project,
  ));
//file dosyasıı
  final appDocumentDir = await getApplicationDocumentsDirectory();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      color: Colors.white,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: LoginPage(),
    );
  }
}
