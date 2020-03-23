import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterappmovie/model/movie.dart';

class DetailMoviePage extends StatefulWidget {
  final Movie movie;

  DetailMoviePage(this.movie);

  @override
  _DetailMoviePageState createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return _buildBodyWidget();
  }

  Widget _buildBodyWidget() {
    return Column(
      children: <Widget>[
        _buildHeaderWidget(),
        _buildDecriptionWidget(),
      ],
    );
  }

  Widget _buildHeaderWidget() {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Image.network(widget.movie.image, fit: BoxFit.fill,)
        )
      ],
    );
  }

  Widget _buildDecriptionWidget() {
    return Container();
  }
}
