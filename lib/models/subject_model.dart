import 'package:applmsbm/models/model.dart';

class SubjectModel extends Model {
  static String table = "subject";

  int? id;
  String subject;
  String description;

  SubjectModel({this.id, required this.subject, required this.description});

  static SubjectModel fromMap(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      subject: json['subject'],
      description: json['description'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'subject': subject,
      'description': description
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
