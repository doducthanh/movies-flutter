import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/language_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutterappmovie/const/cache.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, left: 0),
              child: CloseButton(),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      AppCaches.currentLocale = 0;
                      LanguageBloc.getObject.sink.add(Locale('en', 'US'));
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      title: Text("English").tr(context: context),
                      trailing: (AppCaches.currentLocale == 0) ? Icon(Icons.done, color: Colors.green,) : null
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      AppCaches.currentLocale = 1;
                      LanguageBloc.getObject.sink.add(Locale('vi', 'VN'));
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      title: Text("Vietnamese").tr(context: context),
                      trailing: (AppCaches.currentLocale != 0) ? Icon(Icons.done, color: Colors.green,) : null
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
