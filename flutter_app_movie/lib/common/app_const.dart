import 'package:encrypt/encrypt.dart';

class AppConst {
  static final String apiKey = 'bcd14bb147b438c7bf30b3504fd99915';
  static final String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2QxNGJiMTQ3YjQzOGM3YmYzMGIzNTA0ZmQ5OTkxNSIsInN1YiI6IjVlNzJmOGJlZjlhYTQ3MDAxN2QyYjEwOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b90Psej5Nbtq84gjRGBEkmT2U3Sl1hOEaYn1xK6-KLY';

  static final String homeBarTitle = 'Trang chủ';
  static final String videoBarTitle = 'Videos';
  static final String activityBarTitle = 'Hoạt động';
  static final String contactBarTitle = 'Danh bạ';
  static final String accountBarTitle = 'Tài khoản';

  /// ma hoa
  static final key = Key.fromLength(32);
  static final iv = IV.fromLength(16);
  static final encrypter = Encrypter(AES(key));
}