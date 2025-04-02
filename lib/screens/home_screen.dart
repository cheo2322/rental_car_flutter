import 'package:flutter/material.dart';
import 'package:rental_car_flutter/widgets/bottom_nav_bar.dart';
import 'package:rental_car_flutter/widgets/home_drawer.dart';
import 'package:rental_car_flutter/widgets/my_view_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _isSearching = false;
  static const List<String> _pageTitles = <String>['', 'Página 2', 'Página 3'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      MyListView(),
      Center(
        child: Text('Contenido de la Página 2', style: TextStyle(fontSize: 18)),
      ),
      Center(
        child: Text('Contenido de la Página 3', style: TextStyle(fontSize: 18)),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title:
            _isSearching
                ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Buscar...',
                    border: InputBorder.none,
                  ),
                  onChanged: (String value) {
                    print('Buscando: $value');
                  },
                )
                : Text(_pageTitles[_selectedIndex]),
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
              },
            ),
          if (_selectedIndex == 0 && !_isSearching)
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () {
                print('Calendario abierto');
              },
            ),
        ],
      ),
      drawer: HomeDrawer(
        pageTitles: _pageTitles,
        selectedIndex: _selectedIndex,
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
