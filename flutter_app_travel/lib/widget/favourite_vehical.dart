import 'package:flutter/material.dart';

class FavouriteVehical extends StatelessWidget {
  List list = [
    Icons.airplanemode_active,
    Icons.directions_car,
    Icons.directions_walk,
    Icons.motorcycle,
    Icons.train
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 16),
              height: 70, width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300]
              ),
              child: Icon(list[index], size: 30, color: index == 0 ? Colors.green : Colors.grey[700],),
            );
          }),
    );
  }
}
