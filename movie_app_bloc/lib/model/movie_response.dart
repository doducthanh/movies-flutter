import 'package:movieappbloc/model/movie.dart';

class MovieReponse {
  final List<Movie> movies;
  final String error;

  MovieReponse(this.movies, this.error);

  MovieReponse.fromJson(Map<String, dynamic> json)
      : movies =
          (json['result'] as List).map((i) => Movie.fromJson(i)).toList(),
          error = '';

  MovieReponse.withError(String errorValue)
      : movies = List(),
        error = errorValue;
}
