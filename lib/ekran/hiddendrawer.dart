import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import '../ARACLAR/ekle.dart';
import '../ARACLAR/liste.dart';

import '../json/jsonlıste.dart';
import '../json/searchekranı.dart';
import 'anaekran.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "HOŞGELDİNİZ",
            baseStyle: TextStyle(color: Colors.black, fontSize: 18),
            selectedStyle: TextStyle(
              backgroundColor: Colors.grey,
            ),
            colorLineSelected: Colors.white,
          ),
          MyHomePage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "ARAÇ EKLEME ",
            baseStyle: TextStyle(color: Colors.black, fontSize: 18),
            selectedStyle: TextStyle(
              backgroundColor: Colors.grey,
            ),
            colorLineSelected: Colors.white,
          ),
          const EKLE(
            licesnsePlate: "licensePlate",
          )),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "ARAÇ LİSTESİ ",
            baseStyle: TextStyle(color: Colors.black, fontSize: 18),
            selectedStyle: TextStyle(
              backgroundColor: Colors.grey,
            ),
            colorLineSelected: Colors.white,
          ),
          const LISTELE()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: " TÜM ARAÇLAR LİSTESİ",
            baseStyle: TextStyle(color: Colors.black, fontSize: 18),
            selectedStyle: TextStyle(
              backgroundColor: Colors.grey,
            ),
            colorLineSelected: Colors.white,
          ),
          const searchpage()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorMenu: Colors.grey,
      screens: _pages,
      initPositionSelected: 0,
    );
  }
}
