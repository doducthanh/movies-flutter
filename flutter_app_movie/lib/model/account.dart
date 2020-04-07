import 'package:flutterappmovie/model/movie.dart';

class Account {
  String id;
  String username;
  String email;
  List<Movie> listFavouriteMovie;

  Account(
      {this.id,
      this.username,
      this.email,
      this.listFavouriteMovie});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      id: json["id"] ?? "",
      username: json["username"] ?? "",
      email: json["email"] ?? "",
      listFavouriteMovie: List<Movie>.from(json["favourites"].map((x) => Movie.fromJson(x))) ?? [],
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "favourites": List<dynamic>.from(listFavouriteMovie.map((x) => x.toJson())),
      };

  String toString() => toJson().toString();
}
