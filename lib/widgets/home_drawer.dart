import 'package:flutter/material.dart';
import 'package:rental_car_flutter/screens/car_register.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Cabecera por defecto',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: Text('Register my car'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarRegister()),
              );
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
