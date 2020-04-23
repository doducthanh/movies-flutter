
import 'dart:ui';
import 'package:rxdart/rxdart.dart';

class LanguageBloc {
  static BehaviorSubject _behaviorSubject = BehaviorSubject<Locale>();

  static get getStream => _behaviorSubject.stream;

  static BehaviorSubject get getObject => _behaviorSubject;
}