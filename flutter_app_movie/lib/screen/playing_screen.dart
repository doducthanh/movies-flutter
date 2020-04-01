import 'package:chewie/chewie.dart';
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

  @override
  void initState()  {
    super.initState();
    _videoController = VideoPlayerController.network("http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")
      ..initialize().then((_) {
        _videoController.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _videoController.pause();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            _builIconClose(),
            Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: VideoPlayer(_videoController)
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builIconClose() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
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
}
