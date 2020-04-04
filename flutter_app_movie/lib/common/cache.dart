import 'dart:ffi';

import 'package:flutterappmovie/model/account.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCaches {
  static List<Movie> listMoview = [];
  static bool isLogin = false;
  static String userId = "";

  static Account currentAccount;

  static setCacheUserId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("UserId", id);
  }

  static getCacheUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("UserId");
  }

  static logout() async {
    AppCaches.setCacheUserId(null);
    AppCaches.currentAccount = null;
  }
}