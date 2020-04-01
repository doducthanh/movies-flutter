import 'package:flutter/material.dart';

class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {

  double size = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedContainer"),),
      body: Container(
        child: GestureDetector(
          onTap: () {
            setState(() {
              size += 50;
            });
          },
          child: Center(
            child: AnimatedContainer(
              curve: Curves.bounceIn,
              duration: Duration(seconds: 2),
              child: Container(
                width: size,
                height: size,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
