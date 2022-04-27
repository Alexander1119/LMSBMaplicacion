import 'package:flutter/material.dart';
import 'package:applmsbm/model/subsection.dart';
import 'package:applmsbm/screens/home/video/util/post_template.dart';
import 'package:applmsbm/screens/home/video/util/post_template.dart';

class MyPost1 extends StatelessWidget {
  Subsection subsection;
  MyPost1({required this.subsection});

  @override
  Widget build(BuildContext context) {
    return PostTemplate(
      subsection: subsection,
    );
  }
}
