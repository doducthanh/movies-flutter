import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:flutterappmovie/screen/detail_movie_screen.dart';

class SearchMoviePage extends StatefulWidget {
  List<Movie> allMovie;

  SearchMoviePage(this.allMovie);

  @override
  _SearchMoviePageState createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  List<Movie> listResult = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tìm kiếm"),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode curren = FocusScope.of(context);
          if (!curren.hasPrimaryFocus) {
            curren.unfocus();
          }
        },
        child: Container(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        color: Colors.grey, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Icon(Icons.search)),
                      Expanded(
                        child: TextField(
                          onChanged: (string) {
                            if ((_searchController.text == "") || (string == "")) {
                              setState(() {
                                listResult = [];
                              });
                            }
                            List<Movie> list = [];
                            widget.allMovie.forEach((e) {
                              if (e.name
                                  .toUpperCase()
                                  .contains(string.toUpperCase())) {
                                list.add(e);
                              }
                            });
                            setState(() {
                              listResult = list;
                            });
                            print(string);
                          },
                          decoration: InputDecoration(
                              hintText: "Tìm kiếm", border: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              (listResult.length > 0)
                  ? Expanded(
                      child: Container(
                          margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                          constraints: BoxConstraints(minHeight: 0),
                          child: Flexible(
                            child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  var movie = listResult.elementAt(index) ?? Movie();
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) => DetailMoviePage(movie, widget.allMovie)));
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            child: Image.network(
                                              movie.image,
                                              height: 150,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  movie.name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 24),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text("Đạo diễn: ${movie.director}"),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text("Diễn viên: ${movie.actors}"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => Container(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                itemCount: listResult.length),
                          )),
                    )
                  : Text("")
            ],
          ),
        )),
      ),
    );
  }
}
