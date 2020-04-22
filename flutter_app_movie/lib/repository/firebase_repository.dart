import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterappmovie/model/account.dart';
import 'package:flutterappmovie/model/actor.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:flutterappmovie/model/news.dart';
import 'dart:convert';

/// class chua cac phuong thuc chung de thao tac du lieu tu firebase
class FirebaseRepository {
  final _collection = "movies";

  final _database = Firestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  ///login && logout with FirebaseAutho
  Future<String> signIn(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch(e) {
      return null;
    }
  }

  Future<String> signUp(String email, String password) async {
    try{
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch(e) {
      return null;
    }
  }

  Future<Account> getCurrentUser(String userId) async {
    try {
      Account account;
      DocumentSnapshot json = await _database.collection("account").document(userId).get();
      return Account.fromJson(json.data);
    } catch(e) {
      return null;
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch(e) {
      return false;
    }
  }

  ///lấy danh sách phim
  Future<List<Movie>> getListMovie() async {
    List<Movie> list = [];
    QuerySnapshot result =
        await _database.collection(_collection).getDocuments();
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

  Future<bool> addUser(String id, String userName, String pass, String email) async {
    try {
      await _database.collection("account").document(id).setData({
        'username': userName,
        'password': pass,
        'email': email,
        "id": id
      });
      return true;
    } catch(e) {
      return false;
    }
  }

  Future<List<Account>> getAllAccount() async {
    List<Account> list = [];
    QuerySnapshot result = await _database.collection("account").getDocuments();
    result.documents.forEach((data) {
      list.add(Account.fromJson(data.data));
    });
    return list;
  }

  Future<bool> updateFavouriteMovie(String id, Movie movie) async {
    try {
      Account account = await getCurrentUser(id);
      List<Movie> list = account.listFavouriteMovie;
      list.add(movie);
      account.listFavouriteMovie = list;
      await _database.collection("account").document(id).updateData(account.toJson());
      return true;
    } catch(e) {
      return false;
    }
  }

  ///lấy danh sách tin tức hiển thị
  Future<List<News>> getListNews() async {
    List<News> list = [];
    QuerySnapshot result = await _database.collection("news").getDocuments();
    result.documents.forEach((data) {
      list.add(News.fromJson(data.data));
    });
    return list;
  }
}
