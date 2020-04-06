class Movie {
  String id;
  String name;
  int duration;
  String image;
  String overview;
  String director;
  String actors;
  int watching;

  Movie({this.id,
    this.name,
    this.duration,
    this.image,
    this.overview,
    this.director,
    this.actors,
    this.watching});

  factory Movie.fromJson(Map<String, dynamic> json) =>
      Movie(
          id: json["id"] ?? "",
          name: json["name"] ?? "",
          duration: json["duration"],
          image: json["image"] ?? "",
          overview: json["overview"] ?? "",
          director: json["director"] ?? "",
          actors: json["actors"] ?? "",
          watching: json["watching"]);

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "duration": duration,
        "image": image,
        "overview": overview,
        "director": director,
        "actors": actors,
        "watching": watching
      };
}
