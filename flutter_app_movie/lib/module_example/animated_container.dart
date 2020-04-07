import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimatedContainerPage extends StatefulWidget {
  @override
  _AnimatedContainerPageState createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimatedContainerPage> {

  double size = 100;

  double _updateSize() {
    setState(() {
      size = 200;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedContainer"),),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child:

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton (
                    child: Text('Animate!'),
                    onPressed: () {
                      setState(() {
                        size += 50.0;
                      });
                    },
                  ),

                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: size,
                    height: size,
                    color: Colors.green,
                  ),

                  TweenAnimationBuilder (
                    tween: Tween<double>(begin: 0, end: 2),
                    duration: Duration (seconds: 1),
                    builder: (context, scale, child){
                      return Transform.rotate(angle: scale, child: child,);
                    },
                    child: Container(
                      width: size,
                      height: size,
                      color: Colors.orange,
                    ),
                  ),

                  IgnorePointer(
                    ignoring: true,
                    child: Container(
                      width: 100, height: 100, color: Colors.green,
                    ),
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
