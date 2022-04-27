import 'package:applmsbm/components/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:applmsbm/models/Product.dart';
import 'package:applmsbm/screens/home/components/subjectView.dart';

import '../../../size_config.dart';
import 'section_title.dart';
import 'package:applmsbm/service/teacherService.dart';
import 'package:applmsbm/service/subjectServic.dart';
import 'package:applmsbm/model/person.dart';
import 'package:applmsbm/model/subject.dart';

class MySubjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Todos los cursos", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        //listOnProgress()
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: FutureBuilder(
                future: SubjectService().getSubjects(),
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
