import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unutma/girissayfasi.dart';

class KayitSayfasi extends StatefulWidget {
  KayitSayfasi();

  @override
  State<KayitSayfasi> createState() => _KayitSayfasiState();
}

class _KayitSayfasiState extends State<KayitSayfasi> {
  void initState() {
    super.initState();
  }
//giris sayfasinda tanimladigimiz seylerin aynisini tanimladik

  String? email;
  String? password;
  String? password2;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

// sayfanin tasarimsal ogeleri asagida yaziliyor
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Kayit Ol"),
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
              onChanged: (deger) {
                email = deger;
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

            //metin kutularina yazilan degerler password ve email degiskenlerine esitleniyor
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
            TextField(
              obscureText: true,
              onChanged: (value) {
                password2 = value;
              },
              decoration: InputDecoration(
                  hintText: "Sifrenizi tekrar giriniz",
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                MaterialButton(
                  //kayit ol dugmesine tiklayinca iki sifre alanindan gelen degerler birbirine esitse
                  //kayit fonksiyonu calisiyor

                  onPressed: () async {
                    if (password == password2) {
                      try {
                        //auth kutuphanesinde tanimli email ve sifre ile kullanici olusturmayi saglayan fonksiyona yukarida
                        // textfieldlerdan gelen degerleri gonderiyoruz
                        // eger gelen cevap null degilse yani kayit basariliysa
                        // giris sayfasina gonder diyoruz
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email!, password: password!);
                        if (newUser != null) {
                          Route route = MaterialPageRoute(
                              builder: (context) => GirisSayfasi());
                          Navigator.push(context, route);
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  color: Colors.red,
                  child: Text(
                    "Kayit Ol",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  //zaten hesabim var dugmesine tiklarsak bizi giris sayfasina gonderiyor
                  onPressed: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => GirisSayfasi());
                    Navigator.push(context, route);
                  },
                  color: Colors.red,
                  child: Text(
                    "Zaten Hesabim Var",
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
