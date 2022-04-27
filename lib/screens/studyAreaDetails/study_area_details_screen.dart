import 'package:applmsbm/model/studyAreas.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class StudyAreasDetailsScreen extends StatelessWidget {
  static String routeName = "/study_area";
  @override
  Widget build(BuildContext context) {
    final StudyAreasDetailsArguments agrs = ModalRoute.of(context)!
        .settings
        .arguments as StudyAreasDetailsArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Body(
        studyAreas: agrs.studyAreas,
      ),
    );
  }
}

class StudyAreasDetailsArguments {
  final StudyAreas studyAreas;

  StudyAreasDetailsArguments({required this.studyAreas});
}
