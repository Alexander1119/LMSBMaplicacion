import 'package:applmsbm/model/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentService {
  final String URL = "http://10.0.2.2:8080//student";

  Future<Student> studentByPerson(int id) async {
    String url = URL + "/StudentsByPerson/" + id.toString();
    final response = await http.get(Uri.parse(url));
    return cast(response);
  }

  cast(var response) {
    var responseData = json.decode(response.body);
    Student student = Student(
      idStudent: responseData['idStudent'],
      idPerson: responseData['idPerson'],
      grade: responseData['grade'],
      level: responseData['level'],
    );
    return student;
  }
}
