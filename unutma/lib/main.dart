import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unutma/girissayfasi.dart';

//main fonksiyonu uygulama baslatilinca calisir
//firebase baslatilir
//runapp myappi baslatir
//myapp materialappi baslatir

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      //Materiapp girissayfasini gosterir
      home: GirisSayfasi(),
    );
  }
}
