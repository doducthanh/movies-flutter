import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
//    _readData().then((results) {
//      setState(() {
//        cars = results;
//      });
//    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Get Data'),
              //onPressed: _readData
            ),

            //_carList()
          ],
        ),
      ),
    );
  }

}
