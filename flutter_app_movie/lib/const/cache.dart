import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutterappmovie/model/account.dart';
import 'package:flutterappmovie/model/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppCaches {
  static List<Movie> listMoview = [];
  static bool isLogin = false;
  static String userId = "";
  static int currentLocale = 1;
  
  static Account currentAccount;

  static Locale locale = Locale('vi', 'VN');

  static setCacheUserId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("UserId", id);
  }

  static getCacheUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("UserId");
  }

  static cacheAccount(Account account) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = jsonEncode(account);
    preferences.setString("account", string);
  }

  static Future<Account> getAccount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var string = preferences.getString("account");
    Map<String, dynamic> map = jsonDecode(string);
    var account = Account.fromJson(map);
    return account;
  }

  static logout() async {
    AppCaches.setCacheUserId(null);
    AppCaches.currentAccount = null;
    AppCaches.isLogin = false;
    AppCaches.userId = null;
  }

}