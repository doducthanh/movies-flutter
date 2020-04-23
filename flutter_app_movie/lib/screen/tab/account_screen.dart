import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/language_bloc.dart';
import 'package:flutterappmovie/const/cache.dart';
import 'package:flutterappmovie/screen/animation_example_screen.dart';
import 'package:flutterappmovie/screen/change_language_screen.dart';
import 'package:easy_localization/easy_localization.dart';

import '../playing_screen.dart';

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  get onDidReceiveLocalNotification => null;

  get didReceiveLocalNotificationSubject => null;

  _register() {
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessage();

  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    print("callback notification click");
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('on message $message');
          BotToast.showSimpleNotification(title: message.toString());
          setState(() => _message = message.toString());
        },
        onResume: (Map<String, dynamic> message) async {
          print('on resume $message');
          setState(() => _message = message.toString());
        },
        onLaunch: (Map<String, dynamic> message) async {
          print('on launch $message');
          BotToast.showSimpleNotification(
              title: _message, duration: Duration(seconds: 5));
          setState(() => _message = message.toString());
        },
        onBackgroundMessage: myBackgroundMessageHandler);

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        _message = "Push Messaging token: $token";
      });
      print(_message);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
                    color: Colors.blueAccent,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.cyanAccent ,
                      radius: 60,
                      child: FlutterLogo(size: 60,),
                    ),
                  ),
                ),

                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      InkWell(
                        highlightColor: Colors.grey[200],
                        onTap: (){
                          _register();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("Register My Device"),
                        ),
                      ),

                      InkWell(
                        highlightColor: Colors.grey[200],
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AnimationPage()));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("Silve Appbar"),
                        ),
                      ),

                      InkWell(
                        highlightColor: Colors.grey[200],
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LanguagePage()));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("Change Language").tr(context: context),
                        ),
                      ),
                    ],
                  ),
                )
                // Text("Message: $message")
              ]),
        ),
      ),
    );
  }
}
