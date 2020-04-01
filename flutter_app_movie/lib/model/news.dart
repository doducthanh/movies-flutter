class News {
  String id;
  String title;
  String description;
  String date;
  String urlImage;
  String urlPath;

  News({
    this.id,
    this.title,
    this.description,
    this.date,
    this.urlImage,
    this.urlPath,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    date: json["date"],
    urlImage: json["url_image"],
    urlPath: json["url_path"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "date": date,
    "url_image": urlImage,
    "url_path": urlPath,
  };
}