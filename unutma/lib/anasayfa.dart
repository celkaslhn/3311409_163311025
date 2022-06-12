import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unutma/girissayfasi.dart';
import 'package:unutma/gorevaciklamasi.dart';
import 'package:unutma/gorevekle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:unutma/kayitsayfasi.dart';

class Unutulmayacaklar extends StatefulWidget {
  const Unutulmayacaklar({Key? key}) : super(key: key);

  @override
  State<Unutulmayacaklar> createState() => _UnutulmayacaklarState();
}

class _UnutulmayacaklarState extends State<Unutulmayacaklar> {
  //auth kuutphanesinden bir ornek tanimiliyoruz
  //bu ornegin icinde aktif kullanicinin oturum bilgileri var

  FirebaseAuth? _auth = FirebaseAuth.instance;

  //signout fonksiyonu auth icinden oturum bilgilerini siliyor yani cikis yapiyor
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //floatingactuonbutton kosedeki yuvarlak ekle dugmesini olusturuyor uzeri
      //ne basinca bizi gorevekle sayfasina gonderiyor
      floatingActionButton: Container(
        height: 75.0,
        width: 75.0,
        child: FittedBox(
          child: FloatingActionButton(
            isExtended: true,
            child: Icon(Icons.add),
            onPressed: () {
              Route route =
                  MaterialPageRoute(builder: (context) => GorevEkle());
              Navigator.push(context, route);
            },
          ),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Unutulmayacak"),
        actions: [
          //appbarda cikis yapmaizi saglayan signout fonksiyonunu cagiran bir ikon dugme var
          IconButton(
              onPressed: () {
                _signOut().then((value) {
                  Route route =
                      MaterialPageRoute(builder: (context) => KayitSayfasi());
                  Navigator.push(context, route);
                });
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Column(
        children: [
          //anlik verileri dinleyen bir widget olan streambuilder
          //icinde gelen verileri okuyup her veri icin bir liste ogesi
          //olusturan listview builder var
          StreamBuilder<QuerySnapshot>(
            //stream olarak firestoreaki kullanicinin id si isimli koleksiyondan gelen degerleri
            //sontarih isimli degerlere gore siralayan bir veriyi kullaniyoruz
            stream: FirebaseFirestore.instance
                .collection(_auth!.currentUser!.uid)
                .orderBy('sontarih', descending: true)
                .snapshots(),
            //stream builder, stream disinda bir de builder parametresi aliyor
            //ekrana cizecegimizi widgetlari orada beliriyoriuz
            builder: (context, snapshot) {
              //eger snapshotda yani gelen veride data varsa bos degilse
              //listview builder olustur
              //listviewbuilder ekrana liste yapisi cizmeyi saglar
              return snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      //listview builder bir oge sayisina ihtiyac duyar
                      //oge sayisi olarak snapshottan gelen verinin uzunlugunu veriyoruz
                      itemCount: snapshot.data!.docs.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        //her gelen deger icin bir inkwell yani dokunulabilir bir widget
                        //icinde bir card widgeti
                        //dokunulabilir inkwele tiklayinca bize gorev aciklamasi sayfasina goneriyor
                        // o sayfaya giden aciklama metni de yukaridaki snapshottan gelen
                        // gorev aciklamasi paramatresinden geliyor.
                        return InkWell(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => GorevAciklamasi(
                                      gorevAciklamasi: snapshot
                                          .data!.docs[index]['gorevaciklamasi'],
                                    ));
                            Navigator.push(context, route);
                          },
                          child: Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Row(
                                children: [
                                  //card widgetinin en basinda checkbox var
                                  //degeri firestoredan gelen verinin yapildiMi parametresine gore
                                  //true ya da false aliyor
                                  //eger tiklaninca deger true olursa
                                  //ekrana unutulmadi diye bir alertdialog cikariyor

                                  Checkbox(
                                      value: snapshot.data!.docs[index]
                                          ['yapildiMi'],
                                      onChanged: (value) {
                                        if (value == true) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Center(
                                                  child: Text('Unutulmadi')),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    children: [
                                                      FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Tamam'),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        //yeni veri veritabanina gonderiliyor
                                        FirebaseFirestore.instance
                                            .collection(_auth!.currentUser!.uid)
                                            .doc(snapshot.data!.docs[index].id)
                                            .update({'yapildiMi': value});
                                      }),
                                  Text(
                                    snapshot.data!.docs[index]['gorevbasligi']
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      //eger gelen verinin yapildimi parametresi true ise
                                      //yazinin uzeri cizili olsun
                                      decoration: snapshot.data!.docs[index]
                                                  ['yapildiMi'] ==
                                              true
                                          ? TextDecoration.lineThrough
                                          : null,
                                      decorationThickness: 2,
                                    ),
                                  ),
                                  Spacer(),
                                  //card widgetinin en sonunda silmek icin bir icon button var
                                  //tiklayinca veritabanindan o id ye ait todoyu siliyor.
                                  IconButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection(_auth!.currentUser!.uid)
                                            .doc(snapshot.data!.docs[index]
                                                .id) // <-- Doc ID to be deleted.
                                            .delete() // <-- Delete
                                            .then((_) => print('Deleted'))
                                            .catchError((error) =>
                                                print('Delete failed: $error'));
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : Center(
                      // eger veritababinda veri yoksa donen bir belirtec yani yukleniyor simgesi gosteriyor
                      child: CupertinoActivityIndicator(),
                    );
            },
          ),
        ],
      ),
    );
  }
}
