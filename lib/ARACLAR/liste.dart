import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LISTELE extends StatefulWidget {
  const LISTELE({super.key});

  @override
  State<LISTELE> createState() => _LISTELEState();
}

class _LISTELEState extends State<LISTELE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("arabalar").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 150,
                          child: Text(
                            snapshot.data!.docs[index]["name"],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          width: 120,
                          child: Text(
                            snapshot.data!.docs[index]["job"],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          width: 120,
                          child: Text(
                            snapshot.data!.docs[index]["licensePlate"],
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                            //width: 50,
                            child: IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await snapshot.data!.docs[index].reference.delete();
                          },
                        )),
                      ],
                    )),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    ));
  }
}
