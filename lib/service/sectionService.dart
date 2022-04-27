import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:applmsbm/model/section.dart';

class SectionService {
  final String URL = "http://10.0.2.2:8080//section";

  Future<List<Section>> getSections() async {
    //replace your restFull API here.
    String url = URL + "/Sections";
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    List<Section> subjects = [];
    for (var singleUser in responseData) {
      Section subject = Section(
        idSection: singleUser['idSection'],
        section: singleUser['section'],
        description: singleUser['description'],
        idSubject: singleUser['idSubject'],
        status: singleUser['status'],
      );
      //Adding user to the list.
      subjects.add(subject);
    }
    print("la lista de secciones si llego");

    return subjects;
  }

  Future<List<Section>> getSectionsBySubject(int id) async {
    //replace your restFull API here.
    String url = URL + "/SectionsBySubject/" + id.toString();
    final response = await http.get(Uri.parse(url));
    var responseData = json.decode(response.body);
    List<Section> sections = [];
    for (var singleUser in responseData) {
      Section section = Section(
        idSection: singleUser['idSection'],
        section: singleUser['section'],
        description: singleUser['description'],
        idSubject: singleUser['idSubject'],
        status: singleUser['status'],
      );
      //Adding user to the list.
      sections.add(section);
    }
    print("la lista de secciones si llego");

    return sections;
  }
}
