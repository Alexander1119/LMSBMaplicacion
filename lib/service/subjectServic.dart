import 'package:applmsbm/model/subject.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SubjectService {
  final String URL = "http://10.0.2.2:8080//subject";

  Future<List<Subject>> getSubjects() async {
    //replace your restFull API here.
    String url = URL + "/Subjects";
    final response = await http.get(Uri.parse(url));

    return castList(response);
  }

  Future<List<Subject>> subjectsByStudyArea(int id) async {
    String url = URL + "/SubjectsByStudyArea/" + id.toString();
    print(url);

    final response = await http.get(Uri.parse(url));

    return castList(response);
  }

  List<Subject> castList(var response) {
    var responseData = json.decode(response.body);
    List<Subject> subjects = [];
    for (var singleUser in responseData) {
      Subject subject = Subject(
          id_subject: singleUser['id_subject'],
          subject: singleUser['subject'],
          teacher: singleUser['teacher'],
          studyAreas: singleUser['studyAreas'],
          description: singleUser['description'],
          image: singleUser['image']);

      //Adding user to the list.
      subjects.add(subject);
      print(subjects);
    }
    return subjects;
  }
}
