import 'dart:async';

import 'package:flutterappmovie/model/movie.dart';
import 'package:flutterappmovie/repository/firebase_repository.dart';

class MoviesBloc {
  final StreamController _moviesStream = StreamController<List<Movie>>();
  FirebaseRepository _fireRepository = FirebaseRepository();

  Stream<List<Movie>> get getMoviesStream => _moviesStream.stream;

  StreamController<List<Movie>> get getStreamController => _moviesStream;

  listMovies() async {
    List<Movie> allMovie = await _fireRepository.getListMovie();
    _moviesStream.sink.add(allMovie);
  }

  void dispose() {
    _moviesStream.close();
  }
}
