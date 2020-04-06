
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/account_bloc.dart';
import 'package:flutterappmovie/common/app_const.dart';
import 'package:flutterappmovie/common/cache.dart';
import 'package:flutterappmovie/screen/account_screen.dart';
import 'package:flutterappmovie/screen/activity_screen.dart';
import 'package:flutterappmovie/screen/login/login_screen.dart';
import 'package:flutterappmovie/screen/news_screen.dart';
import 'package:flutterappmovie/screen/videos_screen.dart';

import '../common/base_bottom_bar_item.dart';
import '../common/colors_const.dart';
import 'home_screen.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }

  AccountBloc _accountBloc = AccountBloc();

  bool isLogin = false;
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
    });
  }

  _actionAfterLogin() async {
    BotToast.showSimpleNotification(title: "Đăng nhập thành công");
    setState(() {
      widget.isLogin = true;
      AppCaches.isLogin = true;
    });
  }

  _actionLogout()  {
    CupertinoAlertDialog(
      title: Text("Bạn có muốn đăng xuất tài khoản không?"),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            bool result = await widget._accountBloc.signout();
            if (result) {
              BotToast.showSimpleNotification(title: "Đăng xuất thành công");
              setState(() {
                widget.isLogin = false;
                AppCaches.isLogin = false;
                AppCaches.userId = null;
              });
            }
          },
          child: Text("Có"),
        ),
        FlatButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text("Không"),
        )
      ],
    );

  }

  _showDialog(String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(milliseconds: 400),
      content: Text(
        text,
        style: TextStyle(color: Colors.green, fontSize: 14),
      ),
    ));
  }

  _getAccount() async {
    if(AppCaches.userId != null) {
      AppCaches.account = await widget._accountBloc.getAccount(AppCaches.userId);
    }
  }

  @override
  void initState() {
    super.initState();
    _getAccount();
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
          child: widget.isLogin ? Icon(Icons.arrow_forward) :Icon(Icons.perm_identity),
        ),
        onPressed: (){
          AppCaches.isLogin ? _actionLogout() :
          Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => LoginPage(loginCallback: _actionAfterLogin))
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
              child:  NewsPage(),
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
              child:  AccountPage(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget._accountBloc.dispose();
  }
}