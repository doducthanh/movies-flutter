import 'package:flutter/material.dart';

class ScaleRouter extends PageRouteBuilder {

  final Widget page;

  ScaleRouter({this.page}) : super(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondAnimation,) => page,
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondAnimation,
          Widget child) =>
          ScaleTransition(
            scale: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                parent: animation, curve: Curves.fastOutSlowIn)),
            child: child,
          )
  );
}