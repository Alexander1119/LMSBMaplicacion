import 'package:applmsbm/model/section.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/screens/menu_sections.dart/components/menu_sections.dart';
import 'package:applmsbm/screens/menu_sections.dart/components/content.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  List<Section> sections;
  Subject subject;
  Body({required this.subject, required this.sections}) : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MainWidget(sections: sections, subject: subject),
    );
  }
}
