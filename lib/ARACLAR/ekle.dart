import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class EKLE extends StatefulWidget {
  const EKLE({super.key, required licesnsePlate});

  @override
  State<EKLE> createState() => _EKLEState();
}

class _EKLEState extends State<EKLE> {
  final _formKey = GlobalKey<FormState>();

  var name = "";
  var licensePlate = "";
  var job = "";
  var carColor = "";

  /// Bir metin denetleyicisi oluşturun ve onu geçerli değeri almak için kullanın
  ///
  final nameController = TextEditingController();
  final licensePlateController = TextEditingController();
  final jobController = TextEditingController();
  final carColorController = TextEditingController();
  @override
  void dispose() {
    // Widget elden çıkarıldığında denetleyiciyi temizleyin.
    nameController.dispose();
    licensePlateController.dispose();
    jobController.dispose();
    carColorController.dispose();
    super.dispose();
  }

  clearText() {
    nameController.clear();
    licensePlateController.clear();
    jobController.clear();
    carColorController.clear();
  }

  Future<void> addUser() {
    DocumentReference arabalar =
        FirebaseFirestore.instance.collection("arabalar").doc(licensePlate);
    return arabalar
        .set({
          'name': name,
          'licensePlate': licensePlate,
          'job': job,
          'car-color': carColor
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Failed to Add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              TextField(
                  controller: nameController,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    hintText: 'name',
                    prefixText: ' ',
                    hintStyle: TextStyle(color: Colors.black),
                    focusColor: Colors.black,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                  )),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: licensePlateController,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    hintText: 'licensePlate',
                    prefixText: ' ',
                    hintStyle: TextStyle(color: Colors.black),
                    focusColor: Colors.black,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                  )),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: carColorController,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    hintText: 'carColor',
                    prefixText: ' ',
                    hintStyle: TextStyle(color: Colors.black),
                    focusColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.green,
                    )),
                  )),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: jobController,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    hintText: 'job',
                    prefixText: ' ',
                    hintStyle: TextStyle(color: Colors.black),
                    focusColor: Colors.black,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black,
                    )),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = nameController.text;
                            licensePlate = licensePlateController.text;
                            job = jobController.text;
                            carColor = carColorController.text;
                            addUser();
                            clearText();
                          });
                        }
                      },
                      child: Text(
                        'EKLE',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => {clearText()},
                      child: Text(
                        'SİL',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
