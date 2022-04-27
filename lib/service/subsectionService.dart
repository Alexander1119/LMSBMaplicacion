import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:applmsbm/model/subsection.dart';
import 'package:open_file/open_file.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

class SubsectionService {
  final String URL = "http://10.0.2.2:8080//subsection";

  Future<List<Subsection>> getSubsections() async {
    //replace your restFull API here.
    String url = URL + "/Subsections";
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    //Creating a list to store input data;
    List<Subsection> subsections = [];
    for (var singleUser in responseData) {
      Subsection subsection = Subsection(
          idSubsection: singleUser['idSubsection'],
          subsection: singleUser['subsection'],
          idSection: singleUser['idSection'],
          idTypeContent: singleUser['idTypeContent'],
          pathFile: singleUser['pathFile'],
          status: singleUser['status'],
          description: singleUser['description'],
          viewed: singleUser['viewed']);
      //Adding user to the list.
      subsections.add(subsection);
    }
    return subsections;
  }

  Future<List<Subsection>> getSectionsBySubject(int id) async {
    //replace your restFull API here.
    String url = URL + "/contentBySections/" + id.toString();
    final response = await http.get(Uri.parse(url));

    var responseData = json.decode(response.body);

    List<Subsection> subsections = [];
    for (var singleUser in responseData) {
      Subsection subsection = Subsection(
          idSubsection: singleUser['idSubsection'],
          subsection: singleUser['subsection'],
          idSection: singleUser['idSection'],
          idTypeContent: singleUser['idTypeContent'],
          pathFile: singleUser['pathFile'],
          status: singleUser['status'],
          description: singleUser['description'],
          viewed: singleUser['viewed']);
      //Adding user to the list.
      subsections.add(subsection);
    }
    return subsections;
  }
}
