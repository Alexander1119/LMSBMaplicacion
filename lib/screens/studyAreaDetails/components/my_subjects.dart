import 'package:applmsbm/components/subject_card.dart';
import 'package:applmsbm/model/studyAreas.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/screens/home/components/section_title.dart';
import 'package:applmsbm/service/subjectServic.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class MySubjects extends StatelessWidget {
  final StudyAreas studyAreas;
  const MySubjects({required this.studyAreas});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
              title: "Mis cursos de " + studyAreas.studyAreas, press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder(
                future: SubjectService()
                    .subjectsByStudyArea(studyAreas.idStudyAreas),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    print("no llego ninguna lista");
                    return Container(
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Row(
                      children: [
                        ...List.generate(
                          snapshot.data.length,
                          (index) {
                            Subject subject = snapshot.data[index];

                            return SubjectCard(subject: subject);
                          },
                        ),
                        SizedBox(width: getProportionateScreenWidth(20)),
                      ],
                    );
                  }
                })),
      ],
    );
  }
}
