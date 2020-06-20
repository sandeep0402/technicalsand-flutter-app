import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String _title = 'Technicalsand.com';

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    title: const Text(
      _title,
      style: TextStyle(color: Colors.white),
    ),
    elevation: 0.0,
    backgroundColor: Colors.teal,
  );
}
