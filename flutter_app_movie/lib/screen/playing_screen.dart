import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/const/image.dart';
import 'package:flutterappmovie/utility/app_utility.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

class PlayingPage extends StatefulWidget {
  final String url;

  PlayingPage({@required this.url});

  @override
  _PlayingPageState createState() => _PlayingPageState();
}

class _PlayingPageState extends State<PlayingPage> {
  VideoPlayerController _videoController;

  ChewieController chewieController;

  BehaviorSubject<Duration> _trackingObject = BehaviorSubject<Duration>();

  double opacity = 1.0;

  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4");

    _videoController.addListener(() {
      if (_videoController.value.position != null) {
        _trackingObject.sink.add(_videoController.value.position);
        setState(() {});
      }
    });
    _videoController.setLooping(true);
    _videoController.initialize().then((_) => setState(() {}));
    _videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _videoController.pause();

//        setState(() {
//          opacity = 1.0;
//          Future.delayed(Duration(seconds: 3)).then((value) {
//            setState(() {
//              opacity = 0.0;
//            });
//          });
//        });
      },
      child: Scaffold(
        body: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: VideoPlayer(_videoController)),
                ),
              ),
              Opacity(
                opacity: opacity,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: PlayAndPause(_videoController, _trackingObject)),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController.dispose();
  }
}

class PlayAndPause extends StatefulWidget {
  VideoPlayerController _controller;
  BehaviorSubject<Duration> _behaviorSubject;

  PlayAndPause(this._controller, this._behaviorSubject);

  Duration seekTo = null;
  Duration position = Duration(seconds: 0);

  @override
  _PlayAndPauseState createState() => _PlayAndPauseState();
}

class _PlayAndPauseState extends State<PlayAndPause> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget._controller.value.isPlaying
              ? SizedBox.shrink()
              : Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.black26,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              var result = ((widget._controller.value.position
                                          .inSeconds -
                                      15) <
                                  0);
                              setState(() {
                                widget._controller.seekTo(Duration(
                                    seconds: result
                                        ? 0
                                        : (widget._controller.value.position
                                                .inSeconds -
                                            15)));
                                widget.seekTo =
                                    widget._controller.value.position;
                              });
                            },
                            child: Image.asset(
                              ImagePath.icSkipBack,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget._controller.play();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 80.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              var result = ((widget._controller.value.position
                                          .inSeconds +
                                      15) >
                                  widget._controller.value.duration.inSeconds);
                              setState(() {
                                widget._controller.seekTo(Duration(
                                    seconds: result
                                        ? widget._controller.value.duration
                                            .inSeconds
                                        : (widget._controller.value.position
                                                .inSeconds +
                                            15)));
                                widget.seekTo =
                                    widget._controller.value.position;
                              });
                            },
                            child: Image.asset(
                              ImagePath.icSkipNext,
                              width: 30,
                              height: 30,
                            ),
                          )
                        ],
                      )),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 80,
                        child: StreamBuilder<Duration>(
                            stream: widget._behaviorSubject.stream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                widget.position = snapshot.data;
                              } else {
                                return SizedBox();
                              }
                              return Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Slider(
                                      min: 0.0,
                                      max: widget
                                          ._controller.value.duration.inSeconds
                                          .toDouble(),
                                      inactiveColor: Colors.white,
                                      activeColor: Colors.blueAccent,
                                      value:
                                          snapshot.data.inSeconds.toDouble() ??
                                              0,
                                      onChanged: (newValue) {
                                        widget._controller.seekTo(Duration(
                                            seconds: newValue.toInt()));
                                        widget.seekTo =
                                            Duration(seconds: newValue.toInt());
                                        widget._behaviorSubject.sink.add(
                                            Duration(
                                                seconds: newValue.toInt()));
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 0, 16, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            AppUtility.formatDurationSring(
                                                (snapshot.data == null)
                                                    ? widget.position
                                                    : snapshot.data),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            AppUtility.formatDurationSring(
                                                widget._controller.value
                                                    .duration),
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                    )
                  ],
                ),
        ),
        GestureDetector(
            onTap: () {
              widget._controller.value.isPlaying
                  ? widget._controller.pause()
                  : widget._controller.play();
            },
            child: !widget._controller.value.isPlaying
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topRight,
                          child: SafeArea(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 16, top: 10),
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[300],
                                ),
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
                        Container()
                      ],
                    ),
                  )
                : SizedBox()),
      ],
    );
  }
}
