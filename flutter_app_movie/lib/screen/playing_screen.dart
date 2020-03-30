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
    setState(() async {
      _videoController = await VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
      chewieController = ChewieController(
        videoPlayerController: _videoController,
        aspectRatio: 16 / 9,
        autoPlay: true,
        looping: true,
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        Chewie(
          controller: chewieController,
        ),
    );
  }
}
