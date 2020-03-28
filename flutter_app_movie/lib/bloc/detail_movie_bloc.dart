import 'package:flutterappmovie/model/movie.dart';
import 'package:flutterappmovie/repository/firebase_repository.dart';

class DetailMovieBloc {
  FirebaseRepository _firebaseRepository = FirebaseRepository();

  Future<bool> favouriteMovie(String id, Movie movie) async {
    try {
      await _firebaseRepository.updateFavouriteMovie(id, movie);
      return true;
    } catch (e) {
      return false;
    }
  }
}
