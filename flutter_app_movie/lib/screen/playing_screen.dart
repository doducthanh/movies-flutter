import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  double opacity = 1.0;

  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4");

    _videoController.addListener(() {
      print(_videoController.value.duration);
      setState(() {});
    });
    _videoController.setLooping(true);
    _videoController.initialize().then((_) => setState(() {}));
    _videoController.play();

//    _videoController = VideoPlayerController.network(
//        "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")
//      ..initialize().then((_) {
//        _videoController.play();
//      });
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
                child: PlayAndPause(_videoController),
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

  PlayAndPause(this._controller);

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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SafeArea(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Icon(Icons.close),
                          ),
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
