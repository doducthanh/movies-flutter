import 'package:flutter/material.dart';

class OpacityPage extends StatefulWidget {
  @override
  _OpacityPageState createState() => _OpacityPageState();
}

class _OpacityPageState extends State<OpacityPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: 150, height: 150, color: Colors.red,
          ),

          Opacity(
            opacity: 0.6,
            child: Container(
              width: 150, height: 150, color: Colors.yellow,
            ),
          ),

          Container(
            width: 150, height: 150, color: Colors.green,
          ),
        ],
      ),
    );
  }
}
