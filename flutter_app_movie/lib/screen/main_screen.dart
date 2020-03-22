import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/common/app_const.dart';
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
    MovieBottomBarItem.init(AppConst.moreBarTitle, Icon(Icons.menu)),
  ];

  int _currentSelected = 0;

  Widget _widgetVisiable = HomePage();

  _selectedBottomBar(int index) {
    setState(() {
      _currentSelected = index;
      _widgetVisiable = _getViewByBottomBar(index);
    });
  }

  Widget _getViewByBottomBar(int index) {
    if (index == 0)
      return HomePage();
    else if (index == 1)
      return VideoPage();
    else return Text(index.toString(), style: TextStyle(color: Colors.white60, fontSize: 50),);
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
      body: Center(
        child: _widgetVisiable ?? HomePage(),
      ),
    );
  }
}