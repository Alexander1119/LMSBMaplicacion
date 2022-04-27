import 'package:applmsbm/model/studyAreas.dart';
import 'package:applmsbm/screens/studyAreaDetails/components/more_students.dart';
import 'package:applmsbm/screens/studyAreaDetails/components/my_subjects.dart';
import 'package:applmsbm/screens/studyAreaDetails/components/recommended.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final StudyAreas studyAreas;

  const Body({required this.studyAreas});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          MySubjects(studyAreas: studyAreas),
          Recommended(studyAreas: studyAreas),
          MoreStudents(studyAreas: studyAreas)
        ],
      ),
    );
  }
}
