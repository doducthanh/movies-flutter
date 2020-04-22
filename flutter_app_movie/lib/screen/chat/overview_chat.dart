import 'package:flutter/material.dart';
import 'package:flutterappmovie/model/message.dart';
import 'package:flutterappmovie/model/user.dart';

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
                  color: Colors.orangeAccent[100]),
              child: FavouriteContacts(favourite),
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
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
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
        )
      ],
    );
  }
}

