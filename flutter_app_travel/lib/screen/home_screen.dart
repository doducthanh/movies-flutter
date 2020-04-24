import 'package:flutter/material.dart';
import 'package:flutterapptravel/consts/model.dart';
import 'package:flutterapptravel/screen/detail_place.dart';
import 'package:flutterapptravel/widget/favourite_vehical.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(child: _buildBody())),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), title: Text("")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text(""))
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Color(0xe4e4e4),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width * 3 / 4,
              child: Text(
                "What you would like to find?",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
                textAlign: TextAlign.left,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            child: FavouriteVehical(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: _buildTopDestination(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: _buildExclusiveHotel(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopDestination() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Top Destinations",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            Text(
              "See All",
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.only(top: 16),
          height: 300,
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
              scrollDirection: Axis.horizontal,
              itemCount: listFavourite.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailPlacePage(listFavourite[index])));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 120),
                        height: 160,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "125 activities",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Enjoy best trips from top travel agencies at best prices",
                                style: TextStyle(color: Colors.grey[500]),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        height: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(children: <Widget>[
                            Image.asset(
                              listFavourite[index].urlImage,
                              width: 180,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                            Opacity(
                              opacity: 0.25,
                              child: Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [Colors.black, Colors.white],
                                        begin: FractionalOffset(0, 1),
                                        end: FractionalOffset(0, 0))),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    listFavourite[index].name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        letterSpacing: 1.5),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 14,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        listFavourite[index].country,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget _buildExclusiveHotel() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Exclusive Hotels",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            Text(
              "See All",
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            )
          ],
        ),
        Container(
            padding: EdgeInsets.only(top: 16),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(hotel1.urlImage)))
      ],
    );
  }
}
