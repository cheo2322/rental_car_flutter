import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String id;

  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle de la Imagen')),
      body: Center(
        child: Text('El ID recibido es: $id', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
