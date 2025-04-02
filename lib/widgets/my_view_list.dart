import 'package:flutter/material.dart';
import 'package:rental_car_flutter/screens/detail_page.dart';

class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage(id: '1')),
            );
          },
          child: ListTile(
            leading: Image.network(
              'https://thumbs.dreamstime.com/z/red-retro-car-truck-carries-snowman-decorated-christmas-tree-home-back-beautiful-winter-new-year-s-countryside-landscape-341381538.jpg?ct=jpeg',
            ),
            title: Text('Texto asociado a la imagen 1'),
          ),
        ),
      ],
    );
  }
}
