import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/my_app.dart';

void main() {
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('en', 'US'), Locale('vi', 'VN')],
    path: "assets/languages",
  ));
}