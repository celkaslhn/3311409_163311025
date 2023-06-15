import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class kayityeri {
  Future<String> get dosyaYolu async {
    final konum = await getApplicationDocumentsDirectory();
    return konum.path;
  }

//dosya
  Future<File> get yerelDosya async {
    final yol = await dosyaYolu;
    return File("$yol/yenidosya.txt");
  }

  //dosya okuma
  Future<String> dosyaOku() async {
    try {
      final dosya = await yerelDosya;
      String icerik = await dosya.readAsString();
      return icerik;
    } catch (e) {
      return "boş $e";
    }
  }

  //dosyaya yazma
  Future<File> dosyaYaz(String gicerik) async {
    final dosya = await yerelDosya;
    return dosya.writeAsString("$gicerik");
  }
}

getApplicationDocumentsDirectory() {}

class DosyaIslemleri extends StatefulWidget {
  final kayityeri kayitIslemleri;

  const DosyaIslemleri({super.key, required this.kayitIslemleri});

  @override
  State<DosyaIslemleri> createState() => _DosyaIslemleriState();
}

class _DosyaIslemleriState extends State<DosyaIslemleri> {
  final yaziCtrl = TextEditingController();
  late String veri = "";

  Future<File> veriKaydet() async {
    setState(() {
      veri = yaziCtrl.text;
    });
    return widget.kayitIslemleri.dosyaYaz(veri);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.kayitIslemleri.dosyaOku().then((String deger) {
      setState(() {
        veri = deger;
      });

      void veriOku() {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("gfdgd"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "yazmak",
            ),
            controller: yaziCtrl,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: veriKaydet,
                  child: Text("kaydet"),
                ),
              )),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  onPressed: veriOku,
                  child: Text("oku"),
                ),
              ))
            ],
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Text("$veri"),
          ))
        ],
      ),
    );
  }

  void veriOku() {
    widget.kayitIslemleri.dosyaOku().then((String deger) {
      setState(() {
        veri = deger;
      });
    });
  }
}
