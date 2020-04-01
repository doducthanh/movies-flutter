import 'package:flutter/material.dart';

class TooltipPage extends StatefulWidget {
  @override
  _TooltipPageState createState() => _TooltipPageState();
}

class _TooltipPageState extends State<TooltipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tooltip"),),
      body: Center(

        child: IconButton(
          icon: Icon(Icons.favorite),
          tooltip: "demo tooltip",
        )
      ),
    );
  }
}
