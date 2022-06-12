import 'package:flutter/material.dart';
import 'package:unutma/anasayfa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GorevEkle extends StatefulWidget {
  const GorevEkle({Key? key}) : super(key: key);

  @override
  State<GorevEkle> createState() => _GorevEkleState();
}

class _GorevEkleState extends State<GorevEkle> {
  // sayfa basladiginda calisan getcurrent user
  void initState() {
    super.initState();
    getCurrentUser();
  }

//authun icinde o anda oturum acan kullanicinin oturum bilgileri var
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

//bir todo olusturmak icin gerekli uc degeri tanimladik
  String? gorevBasligi = ' ';
  String? tarihi = ' ';
  String? gorevAciklamasi = ' ';

//todo olusturup veritabanina gondermek icin gerekli createdata fonksiyonu
  createData() {
    //asagidaki textfieldlar degerlerini yukarida tanimladigimizi degiskenlere aktaracak
    // biz de bu degiskenlerden veritabaninan gondermek uzere bir map tanimliyoruz
    //firebase verileri bizden bu yapida istiyor
    Map<String, dynamic> gorev = {
      "gorevbasligi": gorevBasligi,
      "sontarih": tarihi,
      'gorevaciklamasi': gorevAciklamasi,
      'yapildiMi': false,
    };

    //ardindan firebase firestorea kullanicinin idsi isimli koleksiyona
    // yukaridaki gorev isimli mapi gonderiyoruz

    FirebaseFirestore.instance
        .collection(_auth.currentUser!.uid)
        .add(gorev)
        .then((docRef) {
      setState(() {});
      //islem gerceklestikten sonra gorev eklendi yazisinin iceren
      //alertdialog ekrana cikiyor
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(child: Text('Gorev Eklendi')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  //tamam dugmesi bizi onceki sayfaya gonderiyor
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text('Tamam'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
/*
   */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Görev Ekle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                gorevBasligi = value;
              },
              decoration: InputDecoration(
                  hintText: "Görev Başlığı",
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                tarihi = value;
              },
              decoration: InputDecoration(
                  hintText: "Son Tarihi",
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 5,
              onChanged: (value) {
                gorevAciklamasi = value;
              },
              decoration: InputDecoration(
                  hintText: "Görev Açıklaması",
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 5))),
            ),
            SizedBox(
              height: 20,
            ),
            //buton createdata fonksiyonunu cagiriyor
            MaterialButton(
              onPressed: () {
                createData();
              },
              color: Colors.red,
              child: Text(
                "Ekle",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
