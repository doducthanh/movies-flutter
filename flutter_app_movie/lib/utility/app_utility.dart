import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  ///check 1 bien string co null hoac rong ko.
  static bool stringNullOrEmpty(String text) {
    if ((text == null) || (text.isEmpty)) {
      return true;
    } else {
      return false;
    }
  }

  static String formatDurationSring(Duration duration) {
    int valueSeconds = duration.inSeconds;
    int hours = valueSeconds ~/ 3600;
    int minute = (valueSeconds - hours*3600) ~/ 60;
    int second = valueSeconds - hours*3600 - minute*60;
    return AppUtility.formatNumberString(hours) + ":" + AppUtility.formatNumberString(minute)
        + ":" + AppUtility.formatNumberString(second);
  }

  static String formatNumberString(int number) {
    return (number < 10) ? ("0" + number.toString()) : number.toString();
  }
}
