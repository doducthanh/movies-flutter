import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final Movie movie;

  DetailMoviePage(this.movie);

  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  StateVideoPlay stateVideo = StateVideoPlay.notPlay;

  var isFavourite = false;

  @override
  void initState() {
    //_playVideo();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      color: ColorsConst.mainColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeaderWidget(),
            _buildDecriptionWidget(),
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
                  ),),
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
            )
          ),
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
            style: Theme
                .of(context)
                .textTheme
                .bodyText2
                .copyWith(
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
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(
                          color: Colors.white70,
                          fontSize: SizeTextConst.textTitle)),
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    '120 phut',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(
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
        setState(() {
          stateVideo = StateVideoPlay.play;
        });
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
                style: Theme
                    .of(context)
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
              style: Theme
                  .of(context)
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
              style: Theme
                  .of(context)
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
              style: Theme
                  .of(context)
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
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                  if (AppUtility.isLogin()) {} else {
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
                      child: (isFavourite)
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
                        style: Theme
                            .of(context)
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
                        style: Theme
                            .of(context)
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
                        style: Theme
                            .of(context)
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

  Widget _buildDecriptionWidget() {
    return Container(
      height: 300,
      child: _buildVideoPlayer(""),
    );
  }

  Widget _buildVideoPlayer(String url) {
    return Container();
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
}
