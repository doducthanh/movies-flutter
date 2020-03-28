import 'package:flutterappmovie/model/movie.dart';

class Account {
  String id;
  String username;
  String password;
  String email;
  List<Movie> listFavouriteMovie;

  Account(
      {this.id,
      this.username,
      this.password,
      this.email,
      this.listFavouriteMovie});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
      id: json["id"] ?? "",
      username: json["username"] ?? "",
      password: json["password"] ?? "",
      email: json["email"] ?? "",
      listFavouriteMovie: List<Movie>.from(json["favourites"].map((x) => Movie.fromJson(x))) ?? [],
    );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "email": email,
        "favourites": List<dynamic>.from(listFavouriteMovie.map((x) => x.toJson())),
      };
}
