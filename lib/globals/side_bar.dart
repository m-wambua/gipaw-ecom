import 'package:flutter/material.dart';

class CollapsableSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Text(
            'Sidebar Header',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            }),
        ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            }),
        ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            }),
        ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            })
      ],
    ));
  }
}
