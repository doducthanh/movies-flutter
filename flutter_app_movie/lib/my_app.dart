import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/language_bloc.dart';
import 'package:flutterappmovie/const/cache.dart';
import 'package:flutterappmovie/utility/app_utility.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screen/tab/main_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BotToastInit(
      child: StreamBuilder<Locale>(
        stream: LanguageBloc.getStream,
        builder: (context, snapshot) {
          Locale locale;
          if (!snapshot.hasData) {
            locale = Locale('vi', 'VN');
          } else {
            locale = snapshot.data;
          }
          return MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                EasyLocalization.of(context).delegate,
              ],
              supportedLocales: EasyLocalization.of(context).supportedLocales,
              locale: EasyLocalization.of(context).locale = locale,
              debugShowCheckedModeBanner: false,
              navigatorObservers: [BotToastNavigatorObserver()],
              home: MainPage());
        }
      ),
    );
  }
}
