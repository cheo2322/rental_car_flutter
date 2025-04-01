import 'package:flutter/material.dart';
import 'package:rental_car_flutter/widgets/bottom_nav_bar.dart';
import 'package:rental_car_flutter/widgets/home_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key}); // Usar el super parámetro directamente

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _isSearching = false;
  static const List<String> _pageTitles = <String>['', 'Página 2', 'Página 3'];

  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text('Contenido de la Página 1', style: TextStyle(fontSize: 18)),
    ),
    Center(
      child: Text('Contenido de la Página 2', style: TextStyle(fontSize: 18)),
    ),
    Center(
      child: Text('Contenido de la Página 3', style: TextStyle(fontSize: 18)),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            _isSearching
                ? TextField(
                  autofocus: true, // Abre el teclado automáticamente
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    border: InputBorder.none,
                  ),
                  onChanged: (String value) {
                    // Actualiza los resultados de la búsqueda mientras el usuario escribe
                    print('Buscando: $value');
                  },
                )
                : Text(_pageTitles[_selectedIndex]),
        actions: [
          if (_selectedIndex == 0) // Iconos solo en Página 1
            IconButton(
              icon: Icon(
                _isSearching ? Icons.close : Icons.search,
              ), // Alterna lupa y cerrar
              onPressed: () {
                setState(() {
                  _isSearching =
                      !_isSearching; // Alternar entre buscar y mostrar el título
                });
              },
            ),
          if (_selectedIndex == 0 &&
              !_isSearching) // Ícono del calendario solo si no estás buscando
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                // Acción del calendario
                print('Calendario abierto');
              },
            ),
        ],
      ),
      drawer: HomeDrawer(
        pageTitles: _pageTitles,
        selectedIndex: _selectedIndex,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
