import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pro3/ARACLAR/tan%C4%B1m.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  var jsondata;
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _newlist = [];
  getdata() async {
    var response =
        await DefaultAssetBundle.of(context).loadString("assets/csvjson.json");

    jsondata = json.decode(response);
    for (var i = 0; i < jsondata.length; i++) {
      _allUsers.add({
        "name": jsondata[i]["name"],
        "license_plate": jsondata[i]["license_plate"],
        "car-color": jsondata[i]["car-color"],
      });
    }
    //TO SHOW ALL LIST AT INITIAL
    setState(() {
      _newlist = _allUsers;
    });
  }

  //
  @override
  void initState() {
    super.initState();
    getdata();
  }

  void _searchlist(String value) {
    setState(() {
      if (value.isEmpty) {
        _newlist = _allUsers;
      } else {
        _newlist = _allUsers
            .where((element) => element['name']
                .toString()
                .toLowerCase()
                .contains(value.toString().toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                onChanged: (value) {
                  _searchlist(value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: ListView.builder(
                itemCount: _newlist.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => description(
                            context,
                            _newlist[index]['name'],
                            _newlist[index]['license_plate'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      //width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Card(
                        // margin: EdgeInsets.symmetric(horizontal: 10),
                        // margin: EdgeInsets.all(15),
                        color: Colors.grey,
                        child: ListTile(
                          title: Text(
                            _newlist[index]['name'],
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          subtitle: Text(
                            _newlist[index]['car-color'].toString(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          trailing: Text(
                            _newlist[index]['license_plate'],
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
