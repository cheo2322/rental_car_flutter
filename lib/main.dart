import 'package:flutter/material.dart';

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
      drawer: Drawer(
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
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
