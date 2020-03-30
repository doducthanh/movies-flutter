import 'package:flutter/material.dart';
import 'package:flutterappmovie/module_example/custome_container.dart';

class DardBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Advance UI Flutter"),
      ),
        body: Container(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => CustomContainerPaage()));
            },
            child: ListTile(
              title: Text("Custom Container"),
            ),
          ),
        ],
      ),
    ));
  }

}
