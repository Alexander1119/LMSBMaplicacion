import 'package:flutter/material.dart';
import 'package:applmsbm/model/section.dart';
import 'package:applmsbm/model/subsection.dart';
import 'package:applmsbm/screens/home/video/posts/mypost_1.dart';

import 'package:applmsbm/service/subsectionService.dart';

class UserHomePage extends StatelessWidget {
  final Section section;
  UserHomePage({required this.section});

  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: SubsectionService().getSectionsBySubject(section.idSection),
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Subsection> subsection = snapshot.data;
                return PageView(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  children: [
                    MyPost1(
                      subsection: subsection.first,
                    ),
                    MyPost1(
                      subsection: subsection.last,
                    ),
                  ],
                );
              }
            }));
  }
}
