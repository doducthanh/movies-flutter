import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/account_bloc.dart';
import 'package:flutterappmovie/const/appbar_const.dart';
import 'package:flutterappmovie/const/base_bottom_bar_item.dart';
import 'package:flutterappmovie/const/cache.dart';
import 'package:flutterappmovie/const/colors.dart';
import 'package:flutterappmovie/const/value.dart';
import 'package:flutterappmovie/model/account.dart';
import 'package:flutterappmovie/screen/tab/account_screen.dart';
import 'package:flutterappmovie/screen/login/login_screen.dart';
import 'package:flutterappmovie/screen/tab/contacts_screen.dart';
import 'package:flutterappmovie/screen/tab/news_screen.dart';
import 'package:flutterappmovie/screen/playing_screen.dart';
import 'package:flutterappmovie/screen/tab/videos_screen.dart';
import 'package:flutterappmovie/utility/notification.dart';

import 'home_screen.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }

  final AccountBloc _accountBloc = AccountBloc();

}

class MainPageState extends State<MainPage> {
  var _listBottomBar = [
    MovieBottomBarItem.init(AppBarConst.homeBarTitle, Icon(Icons.home)),
    MovieBottomBarItem.init(AppBarConst.videoBarTitle, Icon(Icons.video_library)),
    MovieBottomBarItem.init(
        AppBarConst.activityBarTitle, Icon(Icons.notifications_active)),
    MovieBottomBarItem.init(
        AppBarConst.contactBarTitle, Icon(Icons.perm_contact_calendar)),
    MovieBottomBarItem.init(
        AppBarConst.accountBarTitle, Icon(Icons.account_circle)),
  ];

  int _currentSelected = 0;
  bool isLogin = false;
  _selectedBottomBar(int index) {
    setState(() {
      _currentSelected = index;
    });
  }

  _actionAfterLogin() async {
    BotToast.showSimpleNotification(title: "Đăng nhập thành công");
    widget._accountBloc.getAccountCache();
    setState(() {
      isLogin = true;
      AppCaches.isLogin = true;
    });
  }

  _actionLogout() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Bạn có muốn đăng xuất tài khoản không?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  await widget._accountBloc.signout();
                  Navigator.of(context).pop();
                  BotToast.showSimpleNotification(
                      title: "Đăng xuất thành công");
                  AppCaches.logout();
                  widget._accountBloc.getAccountCache();
                },
                child: Text("Có"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Không"),
              )
            ],
          );
        });
  }

  _showDialog(String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(milliseconds: 400),
      content: Text(
        text,
        style: TextStyle(color: Colors.green, fontSize: TEXT_M),
      ),
    ));
  }

  Future<dynamic> myBackgroundMessagerHandler(Map<String, dynamic> message){
    if (message.containsKey("data")){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PlayingPage()));
    }

    if (message.containsKey("notification")) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PlayingPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    widget._accountBloc.getAccountCache();
    FCMNotification fcm = FCMNotification();
    fcm.configFirebase();

//    if(AppCaches.isLogin) {
//      _actionAfterLogin();
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MAIN_THEME,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: MAIN_THEME,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.yellow,
          onTap: _selectedBottomBar,
          // new
          currentIndex: _currentSelected,
          // new
          items: _listBottomBar),
      floatingActionButton: StreamBuilder<Account>(
        stream: widget._accountBloc.getAccountStream,
        builder: (context, snapshot) {
          var isLogin = false;
          if ((!snapshot.hasData) || (snapshot.data == null)) {
            isLogin = false;
            isLogin = AppCaches.isLogin;
          } else {
            isLogin = true;
          }

          return FloatingActionButton(
            child: Container(
              child: isLogin
                  ? Icon(Icons.arrow_forward)
                  : Icon(Icons.perm_identity),
            ),
            onPressed: () {
              isLogin
                  ? _actionLogout()
                  : Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                          builder: (context) =>
                              LoginPage()));
            },
          );
        }
      ),
      body: Stack(
        children: <Widget>[
          new Offstage(
            offstage: _currentSelected != 0,
            child: new TickerMode(
              enabled: _currentSelected == 0,
              child: new HomePage(),
            ),
          ),
          new Offstage(
            offstage: _currentSelected != 1,
            child: new TickerMode(
              enabled: _currentSelected == 1,
              child: new VideoPage(),
            ),
          ),
          new Offstage(
            offstage: _currentSelected != 2,
            child: new TickerMode(
              enabled: _currentSelected == 2,
              child: NewsPage(),
            ),
          ),
          new Offstage(
            offstage: _currentSelected != 3,
            child: new TickerMode(
              enabled: _currentSelected == 3,
              child: new ContactsPage(),
            ),
          ),
          new Offstage(
            offstage: _currentSelected != 4,
            child: new TickerMode(
              enabled: _currentSelected == 4,
              child: AccountPage(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget._accountBloc.dispose();
  }
}
