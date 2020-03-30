import 'package:flutter/material.dart';

class CustomContainerPaage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.green),
            ),

            Text("Bo tron")
          ]),

          Column(
            children: <Widget>[
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black, style: BorderStyle.solid, width: 3)
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
