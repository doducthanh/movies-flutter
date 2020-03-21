
class Movie {
  //mã số phim
  final int id;

  //chỉ số đánh giá mức đọ phổ biến
  final double popularity;

  //tên phim
  final String title;

  //link ảnh backPoster
  final String backPoster;

  //link ảnh poster
  final String poster;

  //mô tả tổng quan phim
  final String overview;

  //số lượng đánh giá
  final double rating;

  ///Hàm khởi tạo
  Movie(
      this.id,
      this.popularity,
      this.title,
      this.backPoster,
      this.poster,
      this.overview,
      this.rating
  );

  ///Hàm thực hiện convert từ Json sang đối tượng MovieJSON
  ///
  /// ddthanh - 19.03.20

  Movie.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    popularity = json['popularity'],
    title = json['title'],
    backPoster = json['backdrop_path'],
    poster = json['poster_path'],
    overview = json['overview'],
    rating = json['vote_average'].toDouble();

  ///Hàm thực hiện convert từ object sang
  ///
  /// ddthanh - 19.03.20
  Map<String, dynamic> toJSON() =>
      {
        'id' : id,
        'popularity' : popularity,
        'title' : title,
        'backPoster' : backPoster,
        'poster' : poster,
        'overview' : poster,
        'rating' : rating
      };
}