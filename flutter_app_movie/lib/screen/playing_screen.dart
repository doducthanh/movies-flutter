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
  void initState() {
    _videoController = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4');
    chewieController = ChewieController(
      videoPlayerController: _videoController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      looping: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 200, maxHeight: 400),
      child:
        Chewie(
          controller: chewieController,
        ),
    );
  }
}
