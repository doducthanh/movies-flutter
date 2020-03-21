import 'package:dio/dio.dart';
import 'package:movieappbloc/common/app_const.dart';
import 'package:movieappbloc/model/genre.dart';
import 'package:movieappbloc/model/genre_response.dart';
import 'package:movieappbloc/model/movie_response.dart';
import 'package:movieappbloc/model/person_response.dart';

class MovieRepository {
  final String apiKey = AppConst.apiKey;
  static String mainUrl = 'https://www.themoviedb.org/3';
  final Dio _dio = Dio();

  final getPopularUrl = '$mainUrl/movie/popular';
  final getMoviesUrl = '$mainUrl/discover/movie';
  final getPlayingUrl = '$mainUrl/movie/now_playing';
  final getGenreUrl = '$mainUrl/genre/movie/list';
  final getPersonUrl = '$mainUrl/trending/person/week';

  Map<String, dynamic> _getBaseParams() {
    return {
      'api_key' : apiKey,
      'language' : 'en-US',
      'page' : 1
    };
  }

  /// àm lấy về danh sách phim dang thinh hanh
  Future<MovieReponse> getMovies() async {
    var params = _getBaseParams();
    try {
      Response response = await _dio.get(getPopularUrl, queryParameters: params);
      return MovieReponse.fromJson(response.data);
    } catch(error, stackTrace) {
      print('Exception $error, tracking $stackTrace');
      return MovieReponse.withError('$error');
    }
  }

  /// Hàm lấy về danh sách phim đang chiếu
  Future<MovieReponse> getPlayingMovies() async {
    var params = _getBaseParams();
    try {
      Response response = await _dio.get(getPlayingUrl, queryParameters: params);
      return MovieReponse.fromJson(response.data);
    } catch(error, stackTrace) {
      print('Exception $error, tracking $stackTrace');
      return MovieReponse.withError('$error');
    }
  }

  /// Hàm lấy về danh sách thể loại phim.
  Future<GenreResponse> getGenres() async {
    var params = _getBaseParams();
    try {
      Response response = await _dio.get(getGenreUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch(error, stackTrace) {
      print('Exception: $error, tracking: $stackTrace');
      return GenreResponse.withError('$error');
    }
  }

  /// Hàm lấy về danh sách diễn viên
  Future<PersonResponse> getPerson() async {
    var params = {'api_key' : apiKey};
    try {
      Response response = await _dio.get(getPersonUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch(error, stackTrace) {
      print('Exception: $error, tracking: $stackTrace');
      return PersonResponse.withError('$error');
    }
  }

  /// Hàm lấy danh sách phim theo thể loại
  Future<MovieReponse> getMovieByGenre(int id) async {
    var params = _getBaseParams();
    params['with_genres'] = id;
    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieReponse.fromJson(response.data);
    } catch(error, stackTrace) {
      print('Exception: $error, tracking: $stackTrace');
      return MovieReponse.withError('$error');
    }
  }
}