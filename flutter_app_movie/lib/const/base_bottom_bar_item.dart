
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MovieBottomBarItem extends BottomNavigationBarItem {

  static BottomNavigationBarItem init(String title, Icon icon) {
    return new BottomNavigationBarItem(
      icon: icon,
      title: Text(title, style: TextStyle(fontSize: 12),),
    );
  }
}