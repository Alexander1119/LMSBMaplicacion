import 'package:http/http.dart' as http;
import 'package:applmsbm/model/person.dart';
import 'dart:convert';

import 'package:applmsbm/model/teacher.dart';

class TeacherService {
  final String URL = "http://10.0.2.2:8080//teacher";
  final String URL2 = "http://10.0.2.2:8080//person";

  Future<Person> getTeacherById(int id) async {
    //replace your restFull API here.
    String url = URL + "/teacherId/" + id.toString();
    print(url);
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);
    //Creating a list to store input data;\
    Teacher teacher = Teacher(
        idTeacher: responseData['idTeacher'],
        idPerson: responseData['idPerson'],
        level: responseData['level']);
    print("El maestro es : " +
        teacher.idTeacher.toString() +
        " " +
        teacher.idPerson.toString() +
        " " +
        teacher.level.toString());
    String url2 = URL2 + "/personId/" + teacher.idPerson.toString();
    print(url2);

    final response2 = await http.get(Uri.parse(url2));
    var responseData2 = json.decode(response2.body);

    Person person = Person(
      idPerson: responseData2['idPerson'],
      name: responseData2['name'],
      surName: responseData2['surName'],
      email: responseData2['email'],
      password: responseData2['password'],
      image: responseData2['image'],
      status: responseData2['status'],
      date: responseData2['date'],
      gender: responseData2['gender'],
    );
    return person;
  }
}
