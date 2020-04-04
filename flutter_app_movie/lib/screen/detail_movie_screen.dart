import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/bloc/movies_bloc.dart';
import 'package:flutterappmovie/common/cache.dart';
import 'package:flutterappmovie/common/colors_const.dart';
import 'package:flutterappmovie/common/image_path_const.dart';
import 'package:flutterappmovie/common/value_const.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:flutterappmovie/screen/playing_screen.dart';
import 'package:flutterappmovie/utility/app_utility.dart';
import 'package:video_player/video_player.dart';
import 'login/login_screen.dart';

enum StateVideoPlay { notPlay, play, pause }

class DetailMoviePage extends StatefulWidget {
  Movie movie;
  final List<Movie> listMovie;

  DetailMoviePage(this.movie, this.listMovie);

  MoviesBloc _moviesBloc = MoviesBloc();

  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  StateVideoPlay stateVideo = StateVideoPlay.notPlay;
  ScrollController _scrollController = ScrollController();
  var isFavourite = false;

  VideoPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.network(
        "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")
      ..initialize().then((_) {});
    if (AppCaches.currentAccount != null) {
      AppCaches.currentAccount.listFavouriteMovie.forEach((element) {
        if (element.id == widget.movie.id) {
          isFavourite = true;
        }
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: ColorsConst.mainColor,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            _buildHeaderWidget(),
            //_buildDecriptionWidget(),
            _buildGridMoive(widget.listMovie),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderWidget() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Visibility(
            visible: !(stateVideo == StateVideoPlay.notPlay),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                      height: 280,
                      child: PlayingPage(
                          url:
                              'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')),
                ),
                _builIconClose(),
              ],
            ),
          ),
          Visibility(
              visible: (stateVideo == StateVideoPlay.notPlay),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 350,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: NetworkImage(widget.movie.image),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: <Widget>[
                        _builIconClose(),
                        _buildImageAndNameMovie(),
                        _buildButtonPlay(),
                      ],
                    ),
                  ),
                ],
              )),
          //_buildProgessBar()
          _buildOverviewMovie(),
          _buildFavouriteWidget(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Container(
              color: Colors.grey,
              height: 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _builIconClose() {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 30,
            height: 30,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white70),
            child: Icon(Icons.close),
          ),
        ),
      ),
    );
  }

  Widget _buildImageAndNameMovie() {
    return Column(
      children: <Widget>[
        Container(
          child: Image.network(
            widget.movie.image,
            height: 250,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 2),
          child: Text(
            widget.movie.name,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: Colors.white, fontSize: SizeTextConst.textTitle),
          ),
        ),
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Text('2019',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: Colors.white70,
                          fontSize: SizeTextConst.textTitle)),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '120 phut',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: Colors.white70,
                        fontSize: SizeTextConst.textTitle),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonPlay() {
    return FlatButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayingPage()));
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.play_arrow),
            Text('Phát',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white))
          ],
        ),
      ),
    );
  }

//  Widget _buildProgessBar() {
//    return Row(
//      children: <Widget>[
//        LinearProgressIndicator(
//          backgroundColor: Colors.green,
//          value: 20,
//          valueColor:
//        ),
//        Text('Con 40 phut')
//      ],
//    );
//  }

  Widget _buildOverviewMovie() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              widget.movie.overview,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 6),
            alignment: Alignment.topLeft,
            child: Text(
              'Đạo diễn: ${widget.movie.director}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white70),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 6),
            alignment: Alignment.topLeft,
            child: Text(
              'Diễn viên: ${widget.movie.actors}',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFavouriteWidget() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              child: FlatButton(
            onPressed: () {
              if (AppUtility.isLogin()) {
                widget._moviesBloc
                    .addFavouriteMovie(widget.movie, AppCaches.userId);
                setState(() {
                  isFavourite = !isFavourite;
                });
              } else {
                _showDialogFavouriteMovie();
              }
            },
            child: Column(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  child: isFavourite
                      ? Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset(
                            ImagePathConst.icFavouriteRed,
                          ),
                        )
                      : Icon(Icons.favorite),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Yêu thích',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white70),
                  ),
                )
              ],
            ),
          )),
          Container(
              child: FlatButton(
            child: Column(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  child: Icon(Icons.message),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Bình luận',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white70),
                  ),
                )
              ],
            ),
          )),
          Container(
              child: FlatButton(
            child: Column(
              children: <Widget>[
                Container(
                  width: 36,
                  height: 36,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                  child: Icon(Icons.share),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    'Chia sẻ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white70),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildGridMoive(List<Movie> listMovie) {
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
              "Tương tự",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              height: 430,
              width: double.infinity,
              child: GridView.count(
                childAspectRatio: 3 / 2,
                shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                controller: ScrollController(
                  keepScrollOffset: false,
                ),
                scrollDirection: Axis.horizontal,
                children: listMovie.map((movie) {
                  return GestureDetector(
                    onTap: () {
                      _scrollController.animateTo(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                      isFavourite = false;
                      if (AppCaches.currentAccount != null) {
                        AppCaches.currentAccount.listFavouriteMovie.forEach((element) {
                          if (element.id == movie.id) {
                            isFavourite = true;
                          }
                        });
                      }
                      setState(() {
                        widget.movie = movie;
                      });
                    },
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          movie.image,
                          height: 180,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          movie.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              .copyWith(color: Colors.white70, fontSize: 14),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ))
        ],
      ),
    );
  }

  void _showDialogFavouriteMovie() {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Bạn cần đăng nhập để thực hiện chức năng này"),
            actions: <Widget>[
              FlatButton(
                child: Text("Đăng nhập"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => LoginPage()));
                },
              ),
              FlatButton(
                child: Text("Huỷ"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget._moviesBloc.dispose();
  }
}
