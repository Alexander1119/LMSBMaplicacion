import 'package:applmsbm/model/person.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/service/teacherService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:applmsbm/models/Product.dart';
import 'package:applmsbm/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class SubjectCard extends StatelessWidget {
  const SubjectCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.subject,
  }) : super(key: key);

  final double width, aspectRetio;
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: ProductDetailsArguments(subject: subject),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    tag: subject.id_subject.toString(),
                    child: Image.network(subject.image),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subject.subject,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                maxLines: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                      future: TeacherService().getTeacherById(subject.teacher),
                      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else {
                          Person person = snapshot.data;
                          return Text(
                            person.name + " " + person.surName,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                            ),
                          );
                        }
                      }),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                      height: getProportionateScreenWidth(28),
                      width: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: false
                            ? kPrimaryColor.withOpacity(0.15)
                            : kSecondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Heart Icon_2.svg",
                        color: true ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
