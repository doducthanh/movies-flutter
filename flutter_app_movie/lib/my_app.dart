import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/utility/app_utility.dart';

import 'screen/tab/main_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [BotToastNavigatorObserver()],
          home: MainPage()),
    );
  }
}
