
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ThemeBloc {

  static BehaviorSubject _subject = BehaviorSubject<ThemeData>();
  static get getStream => ThemeBloc._subject.stream;
  static Color green = Colors.green;
  static Color grey = Colors.grey[300];

  static void darkTheme() {
    ThemeBloc._subject.sink.add(ThemeData.dark());
    ThemeBloc.green = Colors.white;
    ThemeBloc.grey = Colors.black45;
  }

  static void lightTheme() {
    ThemeBloc._subject.sink.add(ThemeData.light());
    ThemeBloc.green = Colors.green;
    ThemeBloc.grey = Colors.grey[300];
  }

}