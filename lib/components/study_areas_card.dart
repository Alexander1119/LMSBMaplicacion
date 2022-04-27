import 'package:applmsbm/model/studyAreas.dart';
import 'package:applmsbm/screens/details/details_screen.dart';
import 'package:applmsbm/screens/studyAreaDetails/study_area_details_screen.dart';
import 'package:applmsbm/service/subjectServic.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';

class StudyAreasCard extends StatelessWidget {
  const StudyAreasCard({
    Key? key,
    required this.studyAreas,
  }) : super(key: key);

  final StudyAreas studyAreas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            StudyAreasDetailsScreen.routeName,
            arguments: StudyAreasDetailsArguments(studyAreas: studyAreas),
          );
        },
        child: SizedBox(
          width: getProportionateScreenWidth(300),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(children: [
                Image.network(
                  studyAreas.image,
                  fit: BoxFit.cover,
                  width: getProportionateScreenWidth(300),
                  height: 250,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15.0),
                      vertical: getProportionateScreenWidth(10),
                    ),
                    child: FutureBuilder(
                        future: SubjectService()
                            .subjectsByStudyArea(studyAreas.idStudyAreas),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (snapshot.data != null) {
                            return Text.rich(
                              TextSpan(
                                style: TextStyle(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: studyAreas.studyAreas,
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                      text: "\n" +
                                          snapshot.data.length.toString() +
                                          " Cursos"),
                                ],
                              ),
                            );
                          } else {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        })),
              ])),
        ),
      ),
    );
  }
}
