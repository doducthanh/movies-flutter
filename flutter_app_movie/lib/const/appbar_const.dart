import 'package:flutter/cupertino.dart';

class AppBarConst {
  static final String apiKey = 'bcd14bb147b438c7bf30b3504fd99915';
  static final String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2QxNGJiMTQ3YjQzOGM3YmYzMGIzNTA0ZmQ5OTkxNSIsInN1YiI6IjVlNzJmOGJlZjlhYTQ3MDAxN2QyYjEwOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b90Psej5Nbtq84gjRGBEkmT2U3Sl1hOEaYn1xK6-KLY';

  static final String homeBarTitle = 'Trang chủ';
  static final String videoBarTitle = 'Videos';
  static final String activityBarTitle = 'Hoạt động';
  static final String contactBarTitle = 'Danh bạ';
  static final String accountBarTitle = 'Tài khoản';

  static bool isTablet(BuildContext context) => (MediaQuery.of(context).size.width > 800);
}