import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/actors_bloc.dart';
import 'package:flutterappmovie/bloc/movies_bloc.dart';
import 'package:flutterappmovie/common/value_const.dart';
import 'package:flutterappmovie/model/account.dart';
import 'package:flutterappmovie/model/actor.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:flutterappmovie/module_example/dartboard_list_tutorial.dart';
import 'package:flutterappmovie/screen/detail_movie_screen.dart';

import '../common/colors_const.dart';
import '../common/image_path_const.dart';

class HomePage extends StatefulWidget {
  List<Movie> _allMovies = [];

  int indexPageIndicator = 0;

  Account account;

  HomePage({this.account});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  MoviesBloc _moviesBloc = MoviesBloc();
  ActorsBloc _actorsBloc = ActorsBloc();

  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    _moviesBloc.listMovies();
    _actorsBloc.getListActors();
  }

  @override
  void dispose() {
    super.dispose();
    _moviesBloc.dispose();
    _actorsBloc.dispose();
  }

  _showDialog() {
    Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.white,
      duration: Duration(milliseconds: 400),
      content: Text(
        'Tính năng đang phát triển',
        style: TextStyle(color: Colors.green, fontSize: 14),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: ColorsConst.mainColor, body: _buildBody());
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        _moviesBloc.listMovies();
        _actorsBloc.getListActors();
      },
      child: SingleChildScrollView(
        child: Wrap(
          children: <Widget>[
            StreamBuilder<List<Movie>>(
                stream: _moviesBloc.getMoviesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    widget._allMovies = [];
                  } else {
                    widget._allMovies = snapshot.data;
                  }
                  return Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          _buildCaroulSlider(widget._allMovies),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: _buildHeaderWidget(),
                                  ),
                                  _buildPlayButtonWidget()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      _buildListProduct(),
                      _buildOverviewMovie(),
                      SizedBox(
                        height: 18,
                      ),
                      _buildListMoviePopullar(widget._allMovies),
                      _buildListMoviePopullar(widget._allMovies),
                      StreamBuilder<List<Actor>>(
                        stream: _actorsBloc.getSubject.stream,
                        builder: (context, snapshot) {
                          var listActor = snapshot.data;
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            return _buildListActors(listActor);
                          }
                        },
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }

  ///
  Widget _buildCaroulSlider(List<Movie> listMovie) {
    if (listMovie.length == 0) {
      return _buildLoadingWidget(300);
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            CarouselSlider(
                height: 300,
                autoPlay: true,
                viewportFraction: 1.0,
                aspectRatio: 2.0,
                autoPlayInterval: Duration(seconds: 5),
                onPageChanged: (index) {
                  setState(() {
                    widget.indexPageIndicator = index;
                  });
                },
                items: listMovie.map((movie) {
                  return Image.network(
                    movie.image,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  );
                }).toList()),
            DotsIndicator(
              dotsCount: listMovie.length,
              position: widget.indexPageIndicator.toDouble(),
            )
          ],
        ),
      );
    }
  }

  /// vẽ phần header button tìm kiếm, mua gói
  Widget _buildHeaderWidget() {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(children: <Widget>[
          Align(
              child: Image(
            image: AssetImage('assets/icLogo.png'),
            height: 60,
            fit: BoxFit.fitHeight,
          )),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: _showDialog,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white70),
                    child: Center(
                      child: Icon(Icons.search),
                    ),
                  ),
                )),
            GestureDetector(
              onTap: () {
                setState(() {
                  isFavourite = !isFavourite;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white70),
                  child: (isFavourite)
                      ? Image.asset(
                          ImagePathConst.icFavouriteRed,
                          width: 26,
                          height: 26,
                        )
                      : Icon(Icons.favorite),
                ),
              ),
            ),
            RaisedButton(
              onPressed: _showDialog,
              disabledColor: Colors.orange,
              color: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
              ),
              child: Text('Mua gói',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeTextConst.textDescripton)),
            )
          ],
        ),
      ],
    ));
  }

  ///ve button play tren poster phim
  Widget _buildPlayButtonWidget() {
    return FlatButton(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20.0)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.play_arrow),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Phát',
                  style: TextStyle(
                      color: Colors.white, fontSize: SizeTextConst.textTitle),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///ve list sp sunshine
  Widget _buildListProduct() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          PaddingConst.defaultPadding, 12, PaddingConst.defaultPadding, 0),
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'SunShine',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeTextConst.textTitle,
                ),
              )),
          Container(
            height: 120,
            child: ListView(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildProductSunshine('SunShine', ImagePathConst.imgProduct1),
                _buildProductSunshine('SunShine', ImagePathConst.imgProduct2),
                _buildProductSunshine('SunShine', ImagePathConst.imgProduct3),
                _buildProductSunshine('SunShine', ImagePathConst.imgProduct1),
                _buildProductSunshine('SunShine', ImagePathConst.imgProduct2),
                _buildProductSunshine('SunShine', ImagePathConst.imgProduct3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///ve templet cho 1 sp
  Widget _buildProductSunshine(String overview, String imgPath) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => DardBoardPage())
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 6, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              constraints: BoxConstraints(minHeight: 60, maxHeight: 70),
              child: Stack(
                children: <Widget>[
                  Image(
                    image: AssetImage(imgPath),
                    height: 70,
                    fit: BoxFit.fitWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 0, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: FittedBox(
                            child: Text(
                          '09 33',
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      overview,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: SizeTextConst.textDescripton),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewMovie() {
    return Container(
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePathConst.imgPosterDemo),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Fast & Furious 8",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Fast & Furious 8 là phần phim thứ hai trong loạt phim sau"
                  " The Fast and the Furious: Tokyo Drift (2006) không có sự "
                  "tham gia của Paul Walker, nam diễn viên đã qua đời trong một"
                  " tai nạn vào ngày 30 tháng 11 năm 2013 trong thời gian Fast & Furious 7 (2015) đang được bấm máy",
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///danh sach phim thinh hanh trong tuan
  Widget _buildListMoviePopullar(List<Movie> listMovies) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          PaddingConst.defaultPadding, 0, PaddingConst.defaultPadding, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Tất cả',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeTextConst.textTitle,
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 6,
          ),
          (listMovies.length == 0)
              ? _buildLoadingWidget(180)
              : Container(
                  constraints: BoxConstraints(minHeight: 120, maxHeight: 220),
                  child: ListView.builder(
                      itemCount: listMovies.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        if (listMovies == null) {
                          return CircularProgressIndicator();
                        } else {
                          var movie = listMovies[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  this.context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailMoviePage(movie, listMovies)),
                                );
                              },
                              child:
                                  _buildTempleMovie(movie.image, movie.name));
                        }
                      })),
        ],
      ),
    );
  }

  Widget _buildTempleMovie(String imgPath, String title) {
    return Container(
      constraints: BoxConstraints(minHeight: 150, maxHeight: 220),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: Column(
          children: <Widget>[
            Image.network(
              imgPath,
              fit: BoxFit.fitHeight,
              height: 170,
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: SizeTextConst.textDescripton),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListActors(List<Actor> listActor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Top diễn viên hành động',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeTextConst.textTitle,
                    fontWeight: FontWeight.bold),
              )),
          (listActor.length == 0)
              ? CircularProgressIndicator()
              : Container(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: listActor.length,
                      itemBuilder: (context, index) {
                        if (listActor == null) {
                          return CircularProgressIndicator();
                        } else {
                          var actor = listActor[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 8, 8),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(actor.image))),
                                ),
                                Text(
                                  actor.name,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: SizeTextConst.textDescripton),
                                )
                              ],
                            ),
                          );
                        }
                      }),
                ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget(double height) {
    return Container(
      height: height,
      child: Center(
          child: Container(
              width: 30, height: 30, child: CircularProgressIndicator())),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
