import 'package:flutter/material.dart';
import 'package:movieappbloc/common/app_const.dart';
import 'package:movieappbloc/common/base_bottom_bar_item.dart';
import 'package:movieappbloc/screen/home_screen.dart';
import 'package:movieappbloc/screen/main_screen.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main()
    );
  }
}