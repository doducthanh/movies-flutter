import 'dart:async';
import 'package:movieappbloc/model/movie.dart';
import 'package:movieappbloc/repository/move_repository.dart';

class MoviesListBloC {
  StreamController<List<Movie>> _movieStream;

  Stream getMoveStream() => _movieStream.stream;

  MoviesListBloC(){
    if (_movieRepository == null)
      _movieStream = StreamController();
  }

  MovieRepository _movieRepository = MovieRepository();

  Future listMovies() async {
    var movies = await _movieRepository.getMovies();
    _movieStream.sink.add(movies.movies);
  }

}