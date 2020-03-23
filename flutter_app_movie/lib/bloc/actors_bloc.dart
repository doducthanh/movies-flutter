import 'package:flutter/foundation.dart';
import 'package:flutterappmovie/model/actor.dart';
import 'package:flutterappmovie/repository/firebase_repository.dart';
import 'package:rxdart/rxdart.dart';

class ActorsBloc {
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  BehaviorSubject<List<Actor>> _subjectActor = BehaviorSubject<List<Actor>>();

  BehaviorSubject<List<Actor>> get getSubject => _subjectActor.stream;

  getListActors() async {
    var listActors = await _firebaseRepository.getActors();
    _subjectActor.sink.add(listActors);
  }

  void dispose() {
    _subjectActor.close();
  }
}