import 'package:flutter/material.dart';
import 'package:flutterapptravel/bloc/theme_bloc.dart';
import 'package:flutterapptravel/screen/account_screen.dart';
import 'package:flutterapptravel/screen/event_screen.dart';
import 'package:flutterapptravel/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeData>(
      stream: ThemeBloc.getStream,
      builder: (context, snapshot) {
        ThemeData theme;
        if (!snapshot.hasData) {
          theme = ThemeData.light();
        } else {
          theme = snapshot.data;
        }
        return MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: MainPage(),
        );
      }
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text(""))
        ],
        onTap: (index) {
          setState(() {
            indexPage = index;
          });
        },
      ),
      body: IndexedStack(
        index: indexPage,
        children: <Widget>[
          HomePage(),
          EventPage(),
          AccountPage(),
        ],
      ),
    );
  }
}
