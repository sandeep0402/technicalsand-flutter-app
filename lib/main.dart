import 'dart:async';

import 'package:flutter/material.dart';
import 'package:technicalsand/Pager.dart';
import 'package:technicalsand/contact_us.dart' as contact;
import 'package:technicalsand/home.dart';

import 'drawer3d.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.amberAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Drawer3d(),
    );
  }
}
