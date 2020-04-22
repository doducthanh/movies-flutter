import 'package:flutter/material.dart';
import 'package:flutterappmovie/screen/simple2_screen.dart';

import '../main.dart';

class AnimationPage extends StatelessWidget {
  onButtonTap(Widget page, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar & SliverAppBar"),
      ),
      body: Padding(
          padding: EdgeInsets.all(15.0),
          child: RaisedButton(
              child: Text("Onpress"),
              onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Sample2()));
          })),
    );
  }
}
