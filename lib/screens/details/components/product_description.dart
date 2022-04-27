import 'package:applmsbm/model/person.dart';
import 'package:applmsbm/service/personService.dart';
import 'package:applmsbm/service/teacherService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/models/Product.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.subject,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Subject subject;
  final GestureTapCallback? pressOnSeeMore;
  final isFavourite = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Text(
            subject.subject + "\n",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: FutureBuilder(
              future: TeacherService().getTeacherById(subject.teacher),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  Person person = snapshot.data;
                  return Text(
                    person.name + " " + person.surName + "\n",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  );
                }
              }),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            right: getProportionateScreenWidth(64),
          ),
          child: Text(
            subject.description,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: 10,
          ),
        )
      ],
    );
  }
}
