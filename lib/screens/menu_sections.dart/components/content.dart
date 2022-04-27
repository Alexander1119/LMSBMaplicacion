import 'package:applmsbm/model/section.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/model/subsection.dart';
import 'package:applmsbm/screens/menu_sections.dart/components/item_subsection.dart';
import 'package:applmsbm/service/subjectServic.dart';
import 'package:applmsbm/service/subsectionService.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../../../size_config.dart';

class Content extends KFDrawerContent {
  Section section;
  Subject subject;
  Content({required this.section, required this.subject});
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        color: Color(0xFFFCFCFC),
        child: Center(
            child: Column(
          children: [
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  child: Material(
                    shadowColor: Colors.transparent,
                    color: Colors.transparent,
                    child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: widget.onMenuPressed,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.only(left: getProportionateScreenWidth(0)),
                child: FutureBuilder(
                  future: SubsectionService()
                      .getSectionsBySubject(widget.section.idSection),
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      print("no llego ninguna lista");
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      print("la lista si llego");
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(16),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          Subsection subsection = snapshot.data[index];
                          return GestureDetector(
                            onTap: () {},
                            child: ItemSubsection(
                                subsection: subsection,
                                section: widget.section,
                                subject: widget.subject),
                          );
                        },
                      );
                    }
                  },
                )),
          ],
        )),
      ),
    );
  }
}
