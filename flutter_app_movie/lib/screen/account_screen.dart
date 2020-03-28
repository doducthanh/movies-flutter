import 'package:flutter/material.dart';
import 'package:flutterappmovie/common/colors_const.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildInforWidget(),
            _buildListWidget()
          ],
        ),
      ),
    );
  }

  _buildInforWidget(){
    return Container(
      height: 250,
      color: ColorsConst.mainColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlutterLogo(size: 120,),
            Text("Do Duc Thanh", style: TextStyle(color: Colors.white, fontSize: 24),)
          ],
        ),
      ),
    );
  }
  _buildListWidget() {
    return Container(
      child: ListView.separated(
        itemCount: 25,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('item $index'),
          );
        },
      )
    );
  }
}
