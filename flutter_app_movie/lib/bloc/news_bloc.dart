import 'package:flutterappmovie/model/news.dart';
import 'package:flutterappmovie/repository/firebase_repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc {

  BehaviorSubject _behaviorSubject = BehaviorSubject<List<News>>();
  get getStream => _behaviorSubject.stream;

  FirebaseRepository _repository = FirebaseRepository();

  getListNews() async {
    var result = await _repository.getListNews();
    _behaviorSubject.sink.add(result);
  }

}