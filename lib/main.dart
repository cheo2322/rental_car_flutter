import 'package:flutter/material.dart';
import 'package:rental_car_flutter/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Usar el super parámetro directamente

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter App', home: const MyHomePage());
  }
}
