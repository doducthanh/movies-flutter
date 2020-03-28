import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final _formKey = GlobalKey<FormState>();

  var list = ['1', '2', '3'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Image.network(
                  'https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/n/a/nang3-1-poster-scaled-cgv_1.jpg',
                  fit: BoxFit.fill,
                ),
                Text(
                  list[index],
                  style: TextStyle(color: Colors.white, fontSize: 50),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
