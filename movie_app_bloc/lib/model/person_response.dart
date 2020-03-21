import 'package:movieappbloc/model/person.dart';

class PersonResponse {
  final List<Person> persons;
  final String error;

  PersonResponse(this.persons, this.error);

  PersonResponse.fromJson(Map<String, dynamic> json)
      : persons =
  (json['result'] as List).map((i) => Person.fromJson(i)).toList(),
        error = '';

  PersonResponse.withError(String errorValue)
      : persons = List(),
        error = errorValue;
}