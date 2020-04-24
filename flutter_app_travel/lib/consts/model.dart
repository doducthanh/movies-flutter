import 'package:flutterapptravel/consts/images.dart';
import 'package:flutterapptravel/model/hotel.dart';
import 'package:flutterapptravel/model/place.dart';

final hotel1 = Hotel(
  name: "Hotel 0",
  urlImage: HOTEL0,
  timeEnd: "10:00 PM",
  timeStart: "8:00 AM",
  stars: 4
);

final hotel2 = Hotel(
  name: "Hotel 2",
  urlImage: HOTEL1,
  timeEnd: "10:30 PM",
  timeStart: "8:00 AM",
  stars: 5
);

final hotel3 = Hotel(
  name: "Hotel 3",
  urlImage: HOTEL2,
  timeEnd: "10:00 PM",
  timeStart: "7:00 AM",
  stars: 4
);

final gondola = Place(
  name: "Gondola",
  country: "Italy",
  urlImage: GONDOLA,
  listHotel: [hotel1, hotel3]
);

final murano = Place(
    name: "Murano",
    country: "Italy",
    urlImage: MURANO,
    listHotel: [hotel1]
);

final newdelhi = Place(
    name: "Newdelhi",
    country: "Ấn Độ",
    urlImage: NEWDELHI,
    listHotel: [hotel2, hotel3]
);

final newYork = Place(
    name: "NewYork",
    country: "Mỹ",
    urlImage: NEWYORK,
    listHotel: [hotel1, hotel2, hotel3]
);

final paris = Place(
    name: "Paris",
    country: "Pháp",
    urlImage: PARIS,
    listHotel: [hotel2, hotel3]
);

final santorini = Place(
    name: "Santorini",
    country: "Hy Lạp",
    urlImage: SANTORINI,
    listHotel: [hotel3]
);

final saopaulo = Place(
    name: "Saopaulo",
    country: "Brazil",
    urlImage: SAOPAULO,
    listHotel: [hotel2]
);

final stmarksbasilica = Place(
    name: "Stmarksbasilica",
    country: "Venezia",
    urlImage: STMARKBASILICA,
    listHotel: [hotel3]
);

final venice = Place(
    name: "Venice",
    country: "Italy",
    urlImage: VENICE,
    listHotel: [hotel1, hotel2]
);

final listPlace = [gondola, murano, newdelhi, newYork, paris, santorini, saopaulo,  stmarksbasilica, venice];
final listFavourite = [venice, paris, newdelhi, newYork];