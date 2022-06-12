import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:unutma/anasayfa.dart';
import 'package:unutma/kayitsayfasi.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GirisSayfasi extends StatefulWidget {
  GirisSayfasi();

  @override
  State<GirisSayfasi> createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  // BU SAYFA BASLADIGINDA INITSTATE FONKSIYONU CALISIR
  void initState() {
    super.initState();
    //INITSTATE GETCURRENTUSERI CALISTIRIR
    getCurrentUser();
  }

  //ASAGIDAKI TEXTFIELDLERDAN GELEN VERILERI TUTMAK UZERE EMAIL VE SIFRE DEGISKENLERI OLUSUTURUYORUZ
  String? email;
  String? password;
  //OTURUM ACAN KULLANICILARI TUTMAK UZERE FIREBASEAUTH ORNEGI OLUSTURUYORUZ
  final _auth = FirebaseAuth.instance;

  User? loggedInUser;

  //GETCUrrentuser firebaseauth ornegi bos degilse bizi unutulmayacaklar yani ana sayfaya gonderiyor
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        Route route =
            MaterialPageRoute(builder: (context) => Unutulmayacaklar());
        Navigator.push(context, route);
      }
    } catch (e) {
      print(e);
    }
  }

  //asagidaki kodlar sayfanin tasarimini yapmayi sagliyor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giris Yap"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                "UNUTMA!!!",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                  hintText: "E-posta",
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5))),
            ),
            SizedBox(
              height: 20,
            ),

            //metin kutusuna girilen degerler yukarida tanimladigimiz email ve password degiskenlerine esitleniyor
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                  hintText: "Sifre",
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                //satirin icinde iki tane materialbutton var birincisine tiklayinca auth paketinin email ve sifre ile giris yapmayi saglayan fonksiyonuna
                // yukaridaki email ve sifre degiskenlerini gonderiyor
                // eger donen cevap null degilse bizi unutulmayacaklar sayfasina gonderiyor ve
                //kutuphane kendi icinde oturumu yani giris yapan kullaniciyi tutuyor
                MaterialButton(
                  onPressed: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email!, password: password!);
                      if (user != null) {
                        Route route = MaterialPageRoute(
                            builder: (context) => Unutulmayacaklar());
                        Navigator.push(context, route);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  color: Colors.red,
                  child: Text(
                    "Giris Yap",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                // kayit butonuna basilirsa kayit sayfasina gonderiyor
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KayitSayfasi()),
                    );
                  },
                  color: Colors.red,
                  child: Text(
                    "Kayit Ol",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
