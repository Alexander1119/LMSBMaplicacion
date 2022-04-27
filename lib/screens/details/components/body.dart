import 'package:applmsbm/model/section.dart';
import 'package:applmsbm/screens/menu_sections.dart/components/menu_sections.dart';
import 'package:applmsbm/screens/menu_sections.dart/menu_sections_screen.dart';
import 'package:applmsbm/service/sectionService.dart';
import 'package:flutter/material.dart';
import 'package:applmsbm/components/default_button.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/models/Product.dart';
import 'package:applmsbm/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final Subject subject;

  const Body({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ProductImages(subject: subject),
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                subject: subject,
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    //  ColorDots(product: product),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.15,
                            right: SizeConfig.screenWidth * 0.15,
                            bottom: getProportionateScreenWidth(40),
                            top: getProportionateScreenWidth(15),
                          ),
                          child: FutureBuilder(
                              future: SectionService()
                                  .getSectionsBySubject(subject.id_subject),
                              builder:
                                  (BuildContext ctx, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else {
                                  return DefaultButton(
                                    text: "Ingresar",
                                    press: () {
                                      List<Section> sections = [];
                                      for (var i = 0;
                                          i < snapshot.data.length;
                                          i++) {
                                        Section sec = snapshot.data[i];
                                        sections.add(sec);
                                        print(sec.section);
                                      }

                                      Navigator.pushNamed(
                                        context,
                                        MenuSectionsScreen.routeName,
                                        arguments: MenuSectionsArguments(
                                            sections: sections,
                                            subject: subject),
                                      );
                                    },
                                  );
                                }
                              })),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
