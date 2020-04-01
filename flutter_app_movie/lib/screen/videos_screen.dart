import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/screen/item_video_screen.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Watch", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),),
      body: Container(
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return ItemVideo();
            },
            separatorBuilder: (context, index) => Container(
              height: 16,
              color: Color(0xffe4e4e4),
            ),
            itemCount: 10),
      ),
    );
  }
}
