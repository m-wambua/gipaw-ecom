import 'package:flutter/material.dart';

class CollapsableSidebar extends StatelessWidget {
  const CollapsableSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        const DrawerHeader(
          child: Text(
            'Sidebar Header',
            style: TextStyle(color: Colors.white),
          ),
        ),
        ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            }),
        ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            }),
        ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            }),
        ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
            })
      ],
    ));
  }
}
