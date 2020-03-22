
class Movie {
  String id;
  String name;
  String overview;
  String time;
  String imagePoster;
  String image;
  String category;

  Movie(
      this.id,
      this.name,
      this.overview,
      this.time,
      this.imagePoster,
      this.image,
      this.category);

//  Movie.fromSnapshot(DataSnapshot snapshot) :
//    id = snapshot.data['id'],
//    name = snapshot.value['name'],
//    overview = snapshot.value['overview'],
//    time = snapshot.value['time'],
//    imagePoster = snapshot.value['imagePoster'],
//    image = snapshot.value['image'],
//    category = snapshot.value['category'];
}