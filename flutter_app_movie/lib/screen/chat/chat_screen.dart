import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/common/colors_const.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsConst.mainColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Container(
          child: Row(
            children: <Widget>[
              Container(
                width: 26,
                height: 26,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                "Ban quản lý toà nhà",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildListMessage(),
          Divider(
            color: Colors.grey,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.sentiment_satisfied, color: Colors.blue),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueGrey[100]),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Nhập tin nhắn",
                            enabledBorder: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListMessage() {
    return Container(
      child: Flexible(
        child: ListView.separated(
            shrinkWrap: debugInstrumentationEnabled,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    index != 0
                        ? SizedBox()
                        : Center(
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[100]),
                              child: Text(
                                "27-02-2020",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == 0 ? Colors.green : null),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: FittedBox(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.grey[100]),
                                  child: Text("Hello world!! ", style: TextStyle(fontSize: 14),),
                            ),
                          ))
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
                  height: 16,
                ),
            itemCount: 10),
      ),
    );
  }
}
