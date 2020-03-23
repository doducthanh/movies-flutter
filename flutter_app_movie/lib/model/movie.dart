class Movie {
  String id;
  String name;
  int duration;
  String image;

  Movie({
    this.id,
    this.name,
    this.duration,
    this.image,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "duration": duration,
        "image": image,
      };
}
