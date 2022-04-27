import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:applmsbm/model/person.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonService {
  final String URL = "http://10.0.2.2:8080//person";

  Future<Person> login(String email, String password) async {
    String url = URL + "/login";
    print(url + "    " + email + " " + password);

    final response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "email": email,
          "password": password,
        }));
    Person person = cast(response);
    if (person != null) {
      print("Los datos de la persona completa son: " +
          person.idPerson.toString() +
          person.name.toString());

      return person;
    } else {
      print("Se retorna null, la eprsona no exixte");

      return person;
    }
  }

  Future<Person> getPersonById(int? idPerson) async {
    String url = URL + "/personId/" + idPerson.toString();
    print("LINK DE PEROSN ID   " + url);
    final response = await http.get(Uri.parse(url));

    Person person = cast(response);

    return person;
  }

  Person cast(var response) {
    var responseData = json.decode(response.body);

    //Creating a list to store input data;\
    Person person = Person(
        idPerson: responseData['idPerson'],
        name: responseData['name'],
        surName: responseData['surName'],
        email: responseData['email'],
        password: responseData['password'],
        image: responseData['image'],
        status: responseData['status'],
        date: responseData['date'],
        gender: responseData['gender']);
    return person;
  }
}
