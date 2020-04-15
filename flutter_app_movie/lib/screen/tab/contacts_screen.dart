import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterappmovie/screen/chat/chat_screen.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            Divider(
              color: Colors.grey,
            ),
            _buildList()
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 16, right: 16),
      child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Danh bạ",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              )),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            child: TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.black),
                  hintText: "Tìm kiếm",
                  enabledBorder: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Flexible(
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatPage()));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text("Ban quan ly toa nha"),
                      ),
                      Icon(Icons.message),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
