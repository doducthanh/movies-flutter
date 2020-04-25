import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapptravel/consts/model.dart';
import 'package:flutterapptravel/model/place.dart';
import 'package:flutterapptravel/screen/map_screen.dart';

class DetailPlacePage extends StatefulWidget {
  Place place;

  DetailPlacePage(this.place);

  @override
  _DetailPlacePageState createState() => _DetailPlacePageState();
}

class _DetailPlacePageState extends State<DetailPlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Column(
        children: <Widget>[_buildHeader(),
          SizedBox(height: 10,),
          Expanded(child: _buildListPlace())],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 3 / 7,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Image.asset(
                widget.place.urlImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Opacity(
            opacity: 0.2,
            child: Container(height: MediaQuery.of(context).size.height * 3 / 7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.white],
                  begin: FractionalOffset(0, 0.5),
                  end: FractionalOffset(0, 0)
                )
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CloseButton(
                        color: Colors.black,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 30,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Icon(
                            Icons.menu,
                            color: Colors.black,
                            size: 30,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.place.name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.send,
                              size: 14,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              widget.place.country,
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 18),
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage()));
                          },
                          icon: Icon(Icons.location_on, color: Colors.white, size: 30,),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildListPlace() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              setState(() {
                widget.place = listPlace[index];
              });
            },
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              height: MediaQuery.of(context).size.height / 5,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10, right: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).size.height,
                            child: AspectRatio(
                              aspectRatio: 3/4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  listPlace[index].urlImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        Expanded(
                          //padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          child: Container(
                            padding: const EdgeInsets.only(left: 10,),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 150,
                                          child: Text(
                                            listPlace[index].name,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Icon(Icons.star, color: Colors.yellow, size: 14,),
                                            Icon(Icons.star, color: Colors.yellow, size: 14,),
                                            Icon(Icons.star, color: Colors.yellow, size: 14,),
                                            Icon(Icons.star, color: Colors.yellow, size: 14,),
                                            Icon(Icons.star, color: Colors.yellow, size: 14,),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "\$30",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "per pax",
                                          style: TextStyle(color: Colors.grey[500]),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 80,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(18),
                                        color: Colors.lightGreen.withOpacity(0.5),
                                      ),
                                      child: Center(
                                        child: Text("9:00 AM"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 80,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(18),
                                        color: Colors.lightGreen.withOpacity(0.5),
                                      ),
                                      child: Center(
                                        child: Text("9:00 AM"),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              height: 12,
            ),
        itemCount: listPlace.length);
  }
}
