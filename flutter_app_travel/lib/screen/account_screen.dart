import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapptravel/bloc/theme_bloc.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Dark mode"),
                Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    if (value) {
                      ThemeBloc.darkTheme();
                    } else {
                      ThemeBloc.lightTheme();
                    }
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                  activeColor: Colors.green,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
