
class Person {
  //mã số dien vien
  final int id;

  //chỉ số đánh giá mức đọ phổ biến
  final double popularity;

  //tên dien vien
  final String name;

  //link ảnh
  final String profileImg;

  final String know;

  ///Hàm khởi tạo
  Person(
      this.id,
      this.popularity,
      this.name,
      this.profileImg,
      this.know,
      );

  ///Hàm thực hiện convert từ Json sang đối tượng Person
  ///
  /// ddthanh - 19.03.20

  Person.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        popularity = json['popularity'],
        name = json['name'],
        profileImg = json['profile_path'],
        know = json['known_for_department'];

  ///Hàm thực hiện convert từ object sang
  ///
  /// ddthanh - 19.03.20
  Map<String, dynamic> toJSON() =>
      {
        'id' : id,
        'popularity' : popularity,
        'name' : name,
        'profile_path' : profileImg,
        'known_for_department' : know
      };
}