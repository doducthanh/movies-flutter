import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/model/message.dart';
import 'package:flutterappmovie/model/user.dart';
import 'package:flutterappmovie/screen/chat/chat_screen.dart';

class OverviewChatPage extends StatefulWidget {
  @override
  _OverviewChatPageState createState() => _OverviewChatPageState();
}

class _OverviewChatPageState extends State<OverviewChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        leading: BackButton(
          color: Colors.white,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelectorChat(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  FavouriteContacts(favourite),
                  Expanded(
                    child: ListChat(
                      messages: chats,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategorySelectorChat extends StatefulWidget {
  @override
  _CategorySelectorChatState createState() => _CategorySelectorChatState();
}

class _CategorySelectorChatState extends State<CategorySelectorChat> {
  int indexSelect = 0;
  final List<String> categories = ["Message", "Online", "Group", "Request"];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  indexSelect = index;
                });
              },
              child: Text(
                categories[index],
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: (indexSelect == index)
                        ? Colors.white
                        : Colors.grey[400],
                    letterSpacing: 1.2),
              ),
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}

class FavouriteContacts extends StatelessWidget {
  final List<User> favourites;

  FavouriteContacts(this.favourites);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Column(
        children: <Widget>[
          Container(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Favourite Contacts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 4),
            height: 110,
            alignment: Alignment.topLeft,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: favourites.length,
                itemBuilder: (context, index) {
                  return Animator(
                    tween:
                        Tween<Offset>(begin: Offset(3, 0), end: Offset(0, 0)),
                    duration: Duration(milliseconds: 800),
                    builder: (anim) => FractionalTranslation(
                      translation: anim.value,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage(favourites[index].imageUrl),
                              radius: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                favourites[index].name,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class ListChat extends StatefulWidget {
  List<Message> messages;

  ListChat({this.messages});

  @override
  _ListChatState createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: widget.messages.length,
          itemBuilder: (BuildContext context, index) {
            return InkWell(
              highlightColor: Colors.black,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatPage()));
              },
              child: Animator(
                tween: Tween<Offset>(begin: Offset(0, 3), end: Offset(0, 0)),
                duration: Duration(milliseconds: 700),
                builder: (anim) => FractionalTranslation(
                  translation: anim.value,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                          AssetImage(widget.messages[index].sender.imageUrl),
                          radius: 35,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 0, right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.messages[index].sender.name),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.messages[index].text,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(widget.messages[index].time),
                              SizedBox(
                                height: 8,
                              ),
                              widget.messages[index].unread
                                  ? Animator(
                                curve: Curves.bounceInOut,
                                tween: Tween<double>(begin: 0, end: 1),
                                duration: Duration(milliseconds: 1000),
                                builder: (anim) => Transform.scale(
                                    scale: anim.value,
                                    child: Container(
                                      width: 60,
                                      height: 30,
                                      child: Center(
                                          child: Text(
                                            "New",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          color: Colors.red),
                                    )),
                              )
                                  : SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ),
            );
          }),
    );
  }
}
