import 'package:applmsbm/components/study_areas_card.dart';
import 'package:applmsbm/components/subject_card.dart';
import 'package:applmsbm/screens/studyAreaDetails/study_area_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:applmsbm/service/StudyAreasService.dart';
import 'package:applmsbm/service/SubjectServic.dart';
import 'package:applmsbm/model/studyAreas.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class StudyAreasAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Areas de estudio", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        //listOnProgress()
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder(
                future: StudyAreasService().getStudyAreas(),
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
                            StudyAreas studyArea = snapshot.data[index];

                            return StudyAreasCard(studyAreas: studyArea);
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
