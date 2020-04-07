import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappmovie/common/image_path_const.dart';
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
      _trackingObject.sink.add(_videoController.value.position);
      setState(() {});
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

        setState(() {
          opacity = 1.0;
          Future.delayed(Duration(seconds: 3)).then((value) {
            setState(() {
              opacity = 0.0;
            });
          });
        });
      },
      child: Scaffold(
        body: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Expanded(
                  child: Container(
                child: Center(
                  child: AspectRatio(
                      aspectRatio: _videoController.value.aspectRatio,
                      child: VideoPlayer(_videoController)),
                ),
              )),
              Opacity(
                opacity: opacity,
                child: PlayAndPause(_videoController, _trackingObject),
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
                color: Colors.black26,
                child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            var result = ((widget._controller.value.position.inSeconds - 15) < 0);
                            setState(() {
                              widget._controller.seekTo(
                                  Duration(seconds: result ? 0 : (widget._controller.value.position.inSeconds - 15)));
                              widget.seekTo = widget._controller.value.position;
                            });
                          },
                          child: Image.asset(
                            ImagePathConst.icSkipBack,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 80.0,
                        ),
                        GestureDetector(
                          onTap: (){
                            var result = ((widget._controller.value.position.inSeconds + 15) > widget._controller.value.duration.inSeconds);
                            setState(() {
                              widget._controller.seekTo(
                                  Duration(seconds: result ? widget._controller.value.duration.inSeconds : (widget._controller.value.position.inSeconds + 15)));
                              widget.seekTo = widget._controller.value.position;
                            });

                          },
                          child: Image.asset(
                            ImagePathConst.icSkipNext,
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
                        }
                        return Column(
                          children: <Widget>[
                            Expanded(
                              child: Slider(
                                min: 0.0,
                                max: widget._controller
                                    .value.duration.inSeconds
                                    .toDouble(),
                                inactiveColor: Colors.white,
                                activeColor: Colors.blueAccent,
                                value: snapshot.data.inSeconds
                                    .toDouble(),
                                onChanged: (newValue) {
                                  widget._controller.seekTo(Duration(seconds: newValue.toInt()));
                                  widget.seekTo = Duration(
                                      seconds: newValue.toInt());
                                  widget._behaviorSubject.sink.add(Duration(
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
                                          (snapshot.data == null) ? widget.position : snapshot.data),
                                      style: TextStyle(
                                          color: Colors.white),
                                    ),
                                    Text(
                                      AppUtility.formatDurationSring(
                                          widget._controller.value.duration),
                                      style: TextStyle(
                                          color: Colors.white),
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
        ),
      ],
    );
  }
}


//class PlayAndPause extends StatelessWidget {
//  VideoPlayerController _controller;
//  BehaviorSubject<Duration> _behaviorSubject;
//
//  PlayAndPause(this._controller, this._behaviorSubject);
//
//  Duration seekTo = null;
//  Duration position = Duration(seconds: 0);
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Stack(
//      children: <Widget>[
//        AnimatedSwitcher(
//          duration: Duration(milliseconds: 50),
//          reverseDuration: Duration(milliseconds: 200),
//          child: _controller.value.isPlaying
//              ? SizedBox.shrink()
//              : Stack(
//                  children: <Widget>[
//                    Container(
//                      color: Colors.black26,
//                      child: Center(
//                          child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          GestureDetector(
//                            onTap: (){
//                              var result = ((_controller.value.position.inSeconds - 15) < 0);
//                              _controller.seekTo(
//                                  Duration(seconds: result ? 0 : (_controller.value.position.inSeconds - 15)));
//                            },
//                            child: Image.asset(
//                              ImagePathConst.icSkipBack,
//                              width: 30,
//                              height: 30,
//                            ),
//                          ),
//                          Icon(
//                            Icons.play_arrow,
//                            color: Colors.white,
//                            size: 80.0,
//                          ),
//                          GestureDetector(
//                            onTap: (){
//                              var result = ((_controller.value.position.inSeconds + 15) > _controller.value.duration.inSeconds);
//                              _controller.seekTo(
//                                  Duration(seconds: result ? _controller.value.duration.inSeconds : (_controller.value.position.inSeconds + 15)));
//                            },
//                            child: Image.asset(
//                              ImagePathConst.icSkipNext,
//                              width: 30,
//                              height: 30,
//                            ),
//                          )
//                        ],
//                      )),
//                    ),
//                    Align(
//                      alignment: Alignment.bottomCenter,
//                      child: Container(
//                        margin: EdgeInsets.only(bottom: 20),
//                        height: 80,
//                        child: StreamBuilder<Duration>(
//                            stream: _behaviorSubject.stream,
//                            builder: (context, snapshot) {
//                              if (snapshot.hasData) {
//                                position = snapshot.data;
//                              }
//                              return Column(
//                                children: <Widget>[
//                                  Expanded(
//                                    child: Slider(
//                                      min: 0.0,
//                                      max: _controller
//                                          .value.duration.inSeconds
//                                          .toDouble(),
//                                      inactiveColor: Colors.white,
//                                      activeColor: Colors.blueAccent,
//                                      value: snapshot.data.inSeconds
//                                              .toDouble(),
//                                      onChanged: (newValue) {
//                                        seekTo = Duration(
//                                            seconds: newValue.toInt());
//                                        _behaviorSubject.sink.add(Duration(
//                                            seconds: newValue.toInt()));
//                                      },
//                                    ),
//                                  ),
//                                  Expanded(
//                                    child: Padding(
//                                      padding: const EdgeInsets.fromLTRB(
//                                          16, 0, 16, 10),
//                                      child: Row(
//                                        mainAxisAlignment:
//                                            MainAxisAlignment.spaceBetween,
//                                        children: <Widget>[
//                                          Text(
//                                            AppUtility.formatDurationSring(
//                                                (snapshot.data == null) ? position : snapshot.data),
//                                            style: TextStyle(
//                                                color: Colors.white),
//                                          ),
//                                          Text(
//                                            AppUtility.formatDurationSring(
//                                                _controller.value.duration),
//                                            style: TextStyle(
//                                                color: Colors.white),
//                                          )
//                                        ],
//                                      ),
//                                    ),
//                                  )
//                                ],
//                              );
//                            }),
//                      ),
//                    )
//                  ],
//                ),
//        ),
//        GestureDetector(
//          onTap: () {
//            _controller.value.isPlaying
//                ? _controller.pause()
//                : _controller.play();
//          },
//        ),
//      ],
//    );
//  }
//}
