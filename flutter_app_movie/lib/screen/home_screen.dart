import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/actors_bloc.dart';
import 'package:flutterappmovie/bloc/movies_bloc.dart';
import 'package:flutterappmovie/common/value_const.dart';
import 'package:flutterappmovie/model/actor.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:flutterappmovie/screen/detail_movie_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../common/colors_const.dart';
import '../common/image_path_const.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  List<Movie> _allMovies = [];
  MoviesBloc _moviesBloc = MoviesBloc();
  ActorsBloc _actorsBloc = ActorsBloc();

  int indexPageIndicator = 0;

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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          StreamBuilder<List<Movie>>(
              stream: _moviesBloc.getMoviesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  _allMovies = snapshot.data;
                  return Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          _buildPageViewTrendingWidget(
                              _pageController, _allMovies),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Align(
                                            child: Expanded(
                                          child: Image(
                                            image:
                                                AssetImage('assets/icLogo.png'),
                                            height: 60,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )),
                                        _buildHeaderButtonWidget(),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      _buildPlayButtonWidget(),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 10),
                                        child: _buildPageIndicator(
                                            _pageController),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      _buildListProduct(),
                      _buildListMoviePopullar(_allMovies),
                      SizedBox(
                        height: 16,
                      ),
                      _buildListMoviePopullar(_allMovies),
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
                }
              }),
        ],
      ),
    );
  }

  ///vẽ phần Header gồm ảnh + các button
  Widget _buildPageViewTrendingWidget(
      PageController pageController, List<Movie> listMovie) {
    if (listMovie == null) {
      return CircularProgressIndicator();
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 450,
        child: PageView.builder(
          onPageChanged: (index) {
            indexPageIndicator = index;
          },
          controller: pageController,
          itemCount: listMovie.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            var movie = listMovie[index];
            return Image.network(
              movie.image,
              fit: BoxFit.fitWidth,
            );
          },
        ),
      );
    }
  }

  Widget _buildPageIndicator(PageController pageController) {
    return SmoothPageIndicator(
      controller: pageController,
      count: _allMovies.length,
      effect:
          WormEffect(dotWidth: 10, dotHeight: 10, activeDotColor: Colors.blue),
    );
  }

  /// vẽ phần header button tìm kiếm, mua gói
  Widget _buildHeaderButtonWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
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
            onTap: _showDialog,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white70),
                child: Icon(Icons.favorite),
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
    );
  }

  ///ve button play tren poster phim
  Widget _buildPlayButtonWidget() {
    return FlatButton(
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
    );
  }

  ///ve list sp sunshine
  Widget _buildListProduct() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'SunShine',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeTextConst.textTitle,
                ),
              )),
          Container(
            height: 110,
            child: ListView(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _buildProductSunshine('', ImagePathConst.imgProduct1),
                _buildProductSunshine('', ImagePathConst.imgProduct2),
                _buildProductSunshine('', ImagePathConst.imgProduct3),
                _buildProductSunshine('', ImagePathConst.imgProduct1),
                _buildProductSunshine('', ImagePathConst.imgProduct2),
                _buildProductSunshine('', ImagePathConst.imgProduct3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///ve templet cho 1 sp
  Widget _buildProductSunshine(String overview, String imgPath) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                child: Text(
                  'tong quan gioi thieu',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeTextConst.textDescripton),
                ),
              ))
        ],
      ),
    );
  }

  ///danh sach phim thinh hanh trong tuan
  Widget _buildListMoviePopullar(List<Movie> listMovies) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Tất cả',
                style: TextStyle(
                    color: Colors.white, fontSize: SizeTextConst.textTitle),
              )),
          SizedBox(
            height: 6,
          ),
          Container(
              constraints: BoxConstraints(minHeight: 120, maxHeight: 200),
              child: ListView.builder(
                  itemCount: listMovies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var movie = listMovies[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            this.context,
                            MaterialPageRoute(
                                builder: (context) => DetailMoviePage(
                                    listMovies[indexPageIndicator])),
                          );
                        },
                        child: _buildTempleMovie(movie.image, movie.name));
                  })),
        ],
      ),
    );
  }

  Widget _buildTempleMovie(String imgPath, String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Image.network(
              imgPath,
              fit: BoxFit.fitHeight,
            )),
            SizedBox(
              height: 6,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white, fontSize: SizeTextConst.textDescripton),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListActors(List<Actor> listActor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
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
                    color: Colors.white, fontSize: SizeTextConst.textTitle),
              )),
          Container(
            height: 150,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listActor.length,
                itemBuilder: (context, index) {
                  var actor = listActor[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 8, 8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(actor.image))),
                        ),
                        Text(
                          actor.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeTextConst.textDescripton),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
