import 'package:flutter/material.dart';
import 'package:flutterappmovie/module_example/animated_container.dart';
import 'package:flutterappmovie/module_example/custome_container.dart';
import 'package:flutterappmovie/module_example/future_builder_screen.dart';
import 'package:flutterappmovie/module_example/opacity.screen.dart';
import 'package:flutterappmovie/module_example/reorder_listview_screen.dart';
import 'package:flutterappmovie/module_example/table_screen.dart';
import 'package:flutterappmovie/module_example/tooltip_screen.dart';

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

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AnimatedContainerPage()));
            },
            child: ListTile(
              title: Text("Animated Container"),
              subtitle: Text("Xử lý animation trong flutter"),
            ),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => OpacityPage()));
            },
            child: ListTile(
              title: Text("Opacity Widget"),
              subtitle: Text("Xử lý làm mờ widget"),
            ),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FutureBuilderPage()));
            },
            child: ListTile(
              title: Text("Future builder Widget"),
              subtitle: Text("Widget đợi hiển thị sau khi hoàn thành 1 future action"),
            ),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TablePage()));
            },
            child: ListTile(
              title: Text("Table Widget"),
              subtitle: Text("Widget hiển thị dưới dạng bảng"),
            ),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => TooltipPage()));
            },
            child: ListTile(
              title: Text("Tooltip Widget"),
              subtitle: Text("Widget hiển thị message khi focus vao"),
            ),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReorderListview()));
            },
            child: ListTile(
              title: Text("ReorderableListview Widget"),
              subtitle: Text("Widget hiển thị listview"),
            ),
          ),
        ],
      ),
    ));
  }

}
