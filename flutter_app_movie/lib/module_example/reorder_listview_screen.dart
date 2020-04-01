import 'package:flutter/material.dart';

class ReorderListview extends StatefulWidget {
  @override
  _ReorderListviewState createState() => _ReorderListviewState();
}

class _ReorderListviewState extends State<ReorderListview> {

  var list = [1, 2, 3, 4, 5, 6, 7];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ReorderListview"),),
      body: Center(
        child: ReorderableListView(
          children: <Widget>[
            ListTile(
              key: ValueKey(1),
              title: Text("1"),
            ),

            ListTile(
              key: ValueKey(2),
              title: Text("2"),
            ),

            ListTile(
              key: ValueKey(3),
              title: Text("3"),
            ),

            ListTile(
              key: ValueKey(4),
              title: Text("4"),
            ),

            ListTile(
              key: ValueKey(5),
              title: Text("5"),
            ),

            ListTile(
              key: ValueKey(6),
              title: Text("6"),
            ),

            ListTile(
              key: ValueKey(7),
              title: Text("7"),
            ),

          ],
        ),
      ),
    );
  }
}
