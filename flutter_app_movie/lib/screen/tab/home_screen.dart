import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/actors_bloc.dart';
import 'package:flutterappmovie/bloc/movies_bloc.dart';
import 'package:flutterappmovie/const/appbar_const.dart';
import 'package:flutterappmovie/const/base_router.dart';
import 'package:flutterappmovie/const/cache.dart';
import 'package:flutterappmovie/const/value.dart';
import 'package:flutterappmovie/model/account.dart';
import 'package:flutterappmovie/model/actor.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:flutterappmovie/screen/detail_movie_screen.dart';
import 'package:flutterappmovie/screen/playing_screen.dart';
import 'package:flutterappmovie/screen/purchase_screen.dart';
import 'package:flutterappmovie/screen/search_movie_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../const/colors.dart';
import '../../const/image.dart';

class HomePage extends StatefulWidget {
  final Account account;

  HomePage({this.account});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  MoviesBloc _moviesBloc = MoviesBloc();
  ActorsBloc _actorsBloc = ActorsBloc();
  int indexPageIndicator = 0;
  bool isFavourite = false;

  List<Movie> _allMovies = [];

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
        style: TextStyle(color: Colors.green, fontSize: TEXT_M),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: MAIN_THEME, body: _buildBody());
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
                    _allMovies = [];
                  } else {
                    _allMovies = snapshot.data;
                  }
                  return Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: AppBarConst.isTablet(context) ? 540 : 340,
                        child: Stack(
                          children: <Widget>[
                            _buildCaroulSlider(_allMovies),
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
                                      padding: const EdgeInsets.all(PADDING_XXXL),
                                      child: _buildHeaderWidget(),
                                    ),
                                    _buildPlayButtonWidget()
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildListProduct(),
                      _buildOverviewMovie(),
                      SizedBox(
                        height: 18,
                      ),
                      _buildListMoviePopullar(_allMovies),
                      SizedBox(
                        height: 12,
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
                }),
          ],
        ),
      ),
    );
  }

  ///
  Widget _buildCaroulSlider(List<Movie> listMovie) {
    if (listMovie.length == 0) {
      return _buildLoadingWidget(AppBarConst.isTablet(context) ? 500 : 300);
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            CarouselSlider(
                height: AppBarConst.isTablet(context) ? 500 : 300,
                autoPlay: true,
                viewportFraction: 1.0,
                aspectRatio: 2.0,
                autoPlayInterval: Duration(seconds: 5),
                onPageChanged: (index) {
                  Movie movie = listMovie[index];
                  setState(() {
                    if ((AppCaches.currentAccount != null) &&
                        (AppCaches.currentAccount.listFavouriteMovie
                            .contains(movie))) {
                      isFavourite = true;
                    } else {
                      isFavourite = false;
                    }
                    indexPageIndicator = index;
                  });
                },
                items: listMovie.map((movie) {
                  return CachedNetworkImage(
                    imageUrl: movie.image,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        child: Container(
                          height: 300,
                        ),
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.white,
                        period: Duration(microseconds: 1500),
                      );
                    },
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  );
                }).toList()),
            Container(
              width: double.infinity,
              height: 35,
              alignment: Alignment.center,
              child: DotsIndicator(
                dotsCount: listMovie.length,
                position: indexPageIndicator.toDouble(),
              ),
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchMoviePage(_allMovies)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MAIN_THEME),
                        child: Center(
                            child: Image.asset(
                              ImagePath.icSearchGray,
                              width: 24,
                              height: 24,
                            )),
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
                            shape: BoxShape.circle,
                            color: MAIN_THEME),
                        child: (isFavourite)
                            ? Image.asset(
                          ImagePath.icFavouriteRed,
                          width: 24,
                          height: 24,
                        )
                            : Image.asset(
                          ImagePath.icFavouriteGray,
                          width: 24,
                          height: 24,
                        )),
                  ),
                ),
                RaisedButton(
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PurchasePage())
                    );
                  },
                  disabledColor: Colors.orange,
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                  ),
                  child: Text('Buy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: SizeTextConst.textDescripton)).tr(context: context),
                )
              ],
            ),
          ],
        ));
  }

  ///ve button play tren poster phim
  Widget _buildPlayButtonWidget() {
    return FlatButton(
      onPressed: () {
        Navigator.push(context, ScaleRouter(page: PlayingPage()));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
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
                Image.asset(
                  ImagePath.icPlayWhite,
                  width: 28,
                  height: 28,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Play',
                  style: TextStyle(
                      color: Colors.white, fontSize: SizeTextConst.textTitle),
                ).tr(context: context)
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
          PADDING_XXL, PADDING_XXL, PADDING_XXL, 0),
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
                _buildProductSunshine('SunShine', ImagePath.imgProduct1),
                _buildProductSunshine('SunShine', ImagePath.imgProduct2),
                _buildProductSunshine('SunShine', ImagePath.imgProduct3),
                _buildProductSunshine('SunShine', ImagePath.imgProduct1),
                _buildProductSunshine('SunShine', ImagePath.imgProduct2),
                _buildProductSunshine('SunShine', ImagePath.imgProduct3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///ve templet cho 1 sp
  Widget _buildProductSunshine(String overview, String imgPath) {
    double scale = AppBarConst.isTablet(context) ? 1.5 : 1.0;
    return GestureDetector(
      onTap: () {
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => DardBoardPage()));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 6, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage(imgPath),
                      height: 70 * scale,
                      fit: BoxFit.fitHeight,
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
            image: AssetImage(ImagePath.imgPosterDemo),
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
                'All Movie',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeTextConst.textTitle,
                    fontWeight: FontWeight.bold),
              ).tr(context: context)),
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
    var scale = AppBarConst.isTablet(context) ? 1.2 : 1.0;
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: CachedNetworkImage(
                imageUrl: imgPath,
                fit: BoxFit.fitHeight,
                height: 150 * scale,
                placeholder: (context, url) => Container(height: 150,),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
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
    var scale = AppBarConst.isTablet(context) ? 1.5 : 1.0;
    return Container(
      height: 150,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Top Actor',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeTextConst.textTitle,
                    fontWeight: FontWeight.bold),
              ).tr(context: context)),
          (listActor.length == 0)
              ? Container(
                  height: 80 * scale,
                )
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listActor.length,
                      itemBuilder: (context, index) {
                        if (listActor == null) {
                          return CircularProgressIndicator();
                        } else {
                          var actor = listActor[index];
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(actor.image))),
                                  ),
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
