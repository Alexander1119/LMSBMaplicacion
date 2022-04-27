import 'package:flutter/material.dart';

class Subject {
  int id_subject;
  String subject;
  int teacher;
  int studyAreas;
  String description;
  String image;

  Subject({
    required this.id_subject,
    required this.subject,
    required this.teacher,
    required this.studyAreas,
    required this.description,
    required this.image,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id_subject: json['id_subject'],
      subject: json['subject'],
      teacher: json['teacher'],
      studyAreas: json['studyAreas'],
      description: json['description'],
      image: json['image']
    );
  }
}
