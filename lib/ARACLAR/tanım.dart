import 'package:flutter/material.dart';

Widget description(context, name, license_plate) {
  return Scaffold(
    appBar: AppBar(
      title: Text(name.toString()),
    ),
    body: Center(
      child: Text(license_plate.toString()),
    ),
  );
}
