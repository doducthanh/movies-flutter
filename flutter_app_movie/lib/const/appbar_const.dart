import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class AppBarConst {
  static final String apiKey = 'bcd14bb147b438c7bf30b3504fd99915';
  static final String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2QxNGJiMTQ3YjQzOGM3YmYzMGIzNTA0ZmQ5OTkxNSIsInN1YiI6IjVlNzJmOGJlZjlhYTQ3MDAxN2QyYjEwOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.b90Psej5Nbtq84gjRGBEkmT2U3Sl1hOEaYn1xK6-KLY';

  static final String homeBarTitle = "Home";
  static final String videoBarTitle = 'Video';
  static final String activityBarTitle = 'Activity';
  static final String contactBarTitle = 'Contacts';
  static final String accountBarTitle = 'Account';

  static bool isTablet(BuildContext context) => (MediaQuery.of(context).size.width > 800);
}