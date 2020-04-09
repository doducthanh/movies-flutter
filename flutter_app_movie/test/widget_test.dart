import 'package:flutter_test/flutter_test.dart';
import 'package:flutterappmovie/bloc/movies_bloc.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:flutterappmovie/utility/app_utility.dart';

void main() {
  var movieBloc = MoviesBloc();
  var movie = Movie(id: "123456",
      duration: 120,
      image: "",
      overview: "test",
      director: "",
      actors: "",
      watching: 0);

  test("demo test", () {
    expect(AppUtility.formatNumberString(1), "01");
    expect(AppUtility.formatNumberString(1), "1");
  });

  test("test bloc movie", () async {
    var movieBloc = MoviesBloc();
    var movie = Movie(id: "123456", duration: 120, image: "", overview: "test", director: "", actors: "", watching: 0);
    await movieBloc.listMovies();
    movieBloc.getStreamController.sink.add([movie]);
    expectLater(movieBloc, MoviesBloc);
  });
}