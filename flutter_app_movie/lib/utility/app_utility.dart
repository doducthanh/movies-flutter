import 'package:flutter/cupertino.dart';
import 'package:flutterappmovie/common/app_const.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutterappmovie/common/cache.dart';

class AppUtility {

  ///ham ma hoa password
  static String encodeString(String input) {
    return AppConst.encrypter.encrypt(input, iv: AppConst.iv).toString();
  }

  ///ham giai ma pass
  static String decodeString(String input) {
    Encrypted encrypted = input as Encrypted;
    return AppConst.encrypter.decrypt(encrypted, iv: AppConst.iv).toString();
  }

  static bool isLogin() {
    if (AppCaches.isLogin) {
      return true;
    } else {
      return false;
    }
  }

}