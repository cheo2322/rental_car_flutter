import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required List<String> pageTitles,
    required int selectedIndex,
  }) : _pageTitles = pageTitles,
       _selectedIndex = selectedIndex;

  final List<String> _pageTitles;
  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              _pageTitles[_selectedIndex], // Cambia dinámicamente el header del Drawer
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Acción al seleccionar Item 1
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Acción al seleccionar Item 2
            },
          ),
        ],
      ),
    );
  }
}
