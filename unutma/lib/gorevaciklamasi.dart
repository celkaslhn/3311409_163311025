import 'package:flutter/material.dart';
import 'package:unutma/anasayfa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GorevAciklamasi extends StatefulWidget {
  //gorevaciklamasi sayfasi gorevAciklamasi adinda bir parametreyi zorunlu olarak istiyor
  // bu parametre asaigdaki gorevAciklamasi string degerine esitleniyor
  // bu degeri onceki anasayfadan buraya gondermis oluyoruz
  // boylece tekrar veritabanini cagirmaya gerek kalmiyor
  GorevAciklamasi({required this.gorevAciklamasi});
  String? gorevAciklamasi;
  @override
  State<GorevAciklamasi> createState() => _GorevAciklamasiState();
}

class _GorevAciklamasiState extends State<GorevAciklamasi> {
  void initState() {
    super.initState();
    getCurrentUser();
  }

  final _auth = FirebaseAuth.instance;

  User? loggedInUser;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  String? gorevBasligi;
  String? tarihi;
  String? gorevAciklamasi;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Görev Aciklamasi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //ekrana cerceveli bir konteyner ciz
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                width: width - 40,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    //metin olarak onceki sayfadan gelen gorevAciklamasi isimli degeri ekrana yazdir
                    widget.gorevAciklamasi!,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
