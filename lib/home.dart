import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';

import 'Pager.dart';
import 'contact_us.dart';

const String _title = 'Technicalsand.com';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: myDrawer(
              context: context) // Populate the Drawer in the next step.
          ),
      appBar: buildAppBar(),
      body: Pager(),
    );
  }
}

Drawer myDrawer({@required BuildContext context, bool isHomePage}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'TechnicalSand Blog',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Home'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Contact Us'),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => ContactForm()));
          },
        ),
      ],
    ),
  );
}

AppBar buildAppBar() {
  return AppBar(
    centerTitle: true,
    title: const Text(
      _title,
      style: TextStyle(color: Colors.white),
    ),
    elevation: 0.0,
    backgroundColor: Colors.black,
  );
}
