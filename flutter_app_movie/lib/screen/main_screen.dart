import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/common/app_const.dart';
import 'package:flutterappmovie/screen/activity_screen.dart';
import 'package:flutterappmovie/screen/login/login_screen.dart';
import 'package:flutterappmovie/screen/videos_screen.dart';

import '../common/base_bottom_bar_item.dart';
import '../common/colors_const.dart';
import 'home_screen.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {

  var _listBottomBar = [
    MovieBottomBarItem.init(AppConst.homeBarTitle, Icon(Icons.home)),
    MovieBottomBarItem.init(AppConst.videoBarTitle, Icon(Icons.video_library)),
    MovieBottomBarItem.init(AppConst.activityBarTitle, Icon(Icons.notifications_active)),
    MovieBottomBarItem.init(AppConst.contactBarTitle, Icon(Icons.perm_contact_calendar)),
    MovieBottomBarItem.init(AppConst.accountBarTitle, Icon(Icons.account_circle)),
  ];

  int _currentSelected = 0;

  _selectedBottomBar(int index) {
    setState(() {
      _currentSelected = index;
      //_widgetVisiable = _getViewByBottomBar(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.mainColor,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorsConst.mainColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          onTap: _selectedBottomBar, // new
          currentIndex: _currentSelected, // new
          items: _listBottomBar
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          child: Icon(Icons.perm_identity),
        ),
        onPressed: (){
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (context) => LoginPage())
          );
        },
      ),
      body: Stack(
        children: <Widget>[
          new Offstage(
            offstage: _currentSelected != 0,
            child: new TickerMode(
              enabled: _currentSelected == 0,
              child:new HomePage(),
            ),
          ),
          new Offstage(
            offstage: _currentSelected != 1,
            child: new TickerMode(
              enabled: _currentSelected == 1,
              child:  new VideoPage(),
            ),
          ),
          new Offstage(
            offstage: _currentSelected != 2,
            child: new TickerMode(
              enabled: _currentSelected == 2,
              child:  ActivityPage(),
            ),
          ),
          new Offstage(
            offstage: _currentSelected != 3,
            child: new TickerMode(
              enabled: _currentSelected == 3,
              child:  new Text('3'),
            ),
          ),
          new Offstage(
            offstage: _currentSelected != 4,
            child: new TickerMode(
              enabled: _currentSelected == 4,
              child:  new Text('4'),
            ),
          ),
        ],
      ),
    );
  }
}