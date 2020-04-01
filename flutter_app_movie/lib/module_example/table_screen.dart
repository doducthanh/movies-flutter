import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Demo Table"),),
      body: Container(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          children: [
            TableRow(
              children: [
                Text("Họ tên"),
                Text("Số điện thoại"),
                Text("Năm sinh"),
                Text("Quê quán"),
              ]
            ),

            TableRow(
                children: [
                  Text("thanh"),
                  Text("0355871797"),
                  Text("1995"),
                  Text("Hai phong"),
                ]
            ),

            TableRow(
                children: [
                  Text("thanh"),
                  Text("0355871797"),
                  Text("1995"),
                  Text("Hai phong"),
                ]
            ),

            TableRow(
                children: [
                  Text("thanh"),
                  Text("0355871797"),
                  Text("1995"),
                  Text("Hai phong"),
                ]
            ),

            TableRow(
                children: [
                  Text("thanh"),
                  Text("0355871797"),
                  Text("1995"),
                  Text("Hai phong"),
                ]
            ),
          ],
        ),
      ),
    );
  }
}
