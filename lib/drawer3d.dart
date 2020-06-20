import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:flutter/material.dart';
import 'package:technicalsand/contact_us.dart';

import 'Pager.dart';
import 'app_bar.dart';
import 'menu.dart';

class Drawer3d extends StatefulWidget {
  @override
  _Drawer3dState createState() => _Drawer3dState();
}

class _Drawer3dState extends State<Drawer3d> {
  int selectedMenuItemId;
  DrawerScaffoldController controller = DrawerScaffoldController();
  @override
  void initState() {
    selectedMenuItemId = menu.items[0].id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      controller: controller,
      appBar: buildAppBar(),
      drawers: [
        SideDrawer(
          percentage: 0.6,
          drawerWidth: 200,
          degree: 25,
          menu: menu,
          cornerRadius: 50,
          direction: Direction.left,
          animation: true,
          color: Theme.of(context).primaryColor,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
        ),
        SideDrawer(
          cornerRadius: 0,
          menu: menu,
          percentage: 1.0,
          direction: Direction.right,
          animation: true,
          selectorColor: Colors.white,
          color: Theme.of(context).accentColor,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
        ),
      ],
      builder: (context, id) => IndexedStack(
        index: id,
        children: buildMenuWidgets(),
      ),
    );
  }

  List<Widget> buildMenuWidgets() {
    return menu.items
          .map((e) => getWidget(e))
          .toList();
  }

  Widget getWidget(MenuItem e){
    if(e.id == 0){
      return Pager();
    }else if(e.id == 1){
      return ContactForm();
    }else {
      return Center(
        child: Text("Page~${e.title}"),
      );
    }

  }

}
