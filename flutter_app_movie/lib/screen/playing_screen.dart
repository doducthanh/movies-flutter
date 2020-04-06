import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      print("current time playing: ${_videoController.value.position}");
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

class PlayAndPause extends StatelessWidget {
  VideoPlayerController _controller;
  BehaviorSubject<Duration> _behaviorSubject;

  PlayAndPause(this._controller, this._behaviorSubject);

  Duration seekTo;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: _controller.value.isPlaying
              ? SizedBox.shrink()
              : Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.black26,
                      child: Center(
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 100.0,
                        ),
                      ),
                    ),
                    
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        height: 80,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            StreamBuilder<Duration>(
                                stream: _behaviorSubject.stream,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: Container(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(),
                                    ));
                                  }
                                  if (seekTo != null) {
                                    _controller.seekTo(seekTo);
                                  }
                                  return Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: Slider(
                                          min: 0.0,
                                          max: _controller
                                              .value.duration.inSeconds
                                              .toDouble(),
                                          inactiveColor: Colors.white,
                                          activeColor: Colors.blueAccent,
                                          value:
                                              snapshot.data.inSeconds.toDouble(),
                                          onChanged: (newValue) {
                                            seekTo = Duration(
                                                seconds: newValue.toInt());
                                            _behaviorSubject.sink.add(Duration(
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
                                                    snapshot.data),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                AppUtility.formatDurationSring(
                                                    _controller.value.duration),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                })
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
        GestureDetector(
          onTap: () {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          },
        ),
      ],
    );
  }
}
