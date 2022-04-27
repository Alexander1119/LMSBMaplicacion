import 'package:applmsbm/model/studyAreas.dart';
import 'package:applmsbm/model/person.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudyAreasService {
  final String URL = "http://10.0.2.2:8080//studyAreas";

  Future<List<StudyAreas>> getStudyAreas() async {
    //replace your restFull API here.
    String url = URL + "/listStudyAreas";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    //Creating a list to store input data;
    List<StudyAreas> studyAreas = [];
    for (var singleUser in responseData) {
      StudyAreas studyArea = StudyAreas(
          idStudyAreas: singleUser['idStudyAreas'],
          studyAreas: singleUser['studyAreas'],
          image: singleUser['image']);
      studyAreas.add(studyArea);
    }
    return studyAreas;
  }

  Future<StudyAreas> getStudyAreaById(int id) async {
    //replace your restFull API here.
    String url = URL + "/SubjectId/" + id.toString();
    print(url);
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);
    //Creating a list to store input data;\
    StudyAreas studyAreas = StudyAreas(
        idStudyAreas: responseData['idStudyAreas'],
        studyAreas: responseData['studyAreas'],
        image: responseData['image']);
    return studyAreas;
  }
}
