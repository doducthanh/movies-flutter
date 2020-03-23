import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterappmovie/model/actor.dart';
import 'package:flutterappmovie/model/movie.dart';

/// class chua cac phuong thuc chung de thao tac du lieu tu firebase

class FirebaseRepository {

  final _collection = "movies";

  final _database = Firestore.instance;

  List<Movie> _allMovies = [Movie(id:'',name: 'BloodShot', duration: 0,
      image:'https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/b/l/bloodshot_cgv_1.jpg'),
    Movie(id:'',name: 'Vì anh vẫn tin', duration: 0,
        image:'https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/i/-/i-still-believe-1-poster-cgv_1.jpg'),
    Movie(id:'',name: 'Truy tìm phép thuật', duration: 0,
        image:'https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/p/o/poster_onward_official_1__1.jpg'),
    Movie(id:'',name: 'Lời hứa của cha', duration: 0,
        image:'https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/n/a/nang3-1-poster-scaled-cgv_1.jpg'),
    Movie(id:'',name: 'Căn hộ của quỷ', duration: 0,
        image:'https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/p/o/poster_payoff_-_malasana_cgv_1.jpg'),
    Movie(id:'',name: 'Loạn nhịp', duration: 0,
        image:'https://www.cgv.vn/media/catalog/product/cache/1/small_image/240x388/dd828b13b1cb77667d034d5f59a82eb6/l/o/loan-nhip_1.png')];


  ///lấy danh sách phim
  Future<List<Movie>> getListMovie() async {
    List<Movie> list = [];
    QuerySnapshot result = await _database.collection(_collection).getDocuments();
    //var list = result.documents.map((snapshot) => Movie.fromJson(snapshot.data));
    result.documents.forEach((data) {
      list.add(Movie.fromJson(data.data));
    });
    return list;
  }

  Future<List<Actor>> getActors() async {
    List<Actor> list = [];
    QuerySnapshot result = await _database.collection("actors").getDocuments();
    result.documents.forEach((data) {
      list.add(Actor.fromJson(data.data));
    });
    return list;
  }
}