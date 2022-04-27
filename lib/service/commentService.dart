import 'dart:convert';
import 'package:applmsbm/model/subsection.dart';
import 'package:http/http.dart' as http;
import 'package:applmsbm/model/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentService {
  final String URL = "http://10.0.2.2:8080//subsection";

  Future<List<Comment>> commentsBySubsection(int id) async {
    String url = URL + "/commentsBySubsection/" + id.toString();
    print(url);

    final response = await http.get(Uri.parse(url));

    return castList(response);
  }

  Future<void> addCommet(
      String mess, Subsection subsection, int idStudent) async {
    print("Comment save: " + mess + "idStudent" + idStudent.toString());
    var response = await http.post(
        Uri.parse("http://10.0.2.2:8080//subsection/addComment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'comment': mess,
          'idSubsection': subsection.idSubsection.toString(),
          'idStudent': idStudent.toString(),
          'date': DateTime.now().year.toString() +
              "-" +
              DateTime.now().month.toString() +
              "-" +
              DateTime.now().day.toString(),
          'time': "12:12:12"
        }));
  }

  List<Comment> castList(var response) {
    var responseData = json.decode(response.body);
    List<Comment> comments = [];
    for (var singleUser in responseData) {
      Comment comment = Comment(
          idComment: singleUser['idComment'],
          comment: singleUser['comment'],
          idSubsection: singleUser['idSubsection'],
          idStudent: singleUser['idStudent'],
          date: singleUser['date'],
          time: singleUser['time']);

      //Adding user to the list.
      comments.add(comment);
      print(comments);
    }
    return comments;
  }

  Comment cast(var response) {
    var responseData = json.decode(response.body);
    Comment comment = Comment(
        idComment: responseData['idComment'],
        comment: responseData['comment'],
        idSubsection: responseData['idSubsection'],
        idStudent: responseData['idStudent'],
        date: responseData['date'],
        time: responseData['time']);

    return comment;
  }
}
