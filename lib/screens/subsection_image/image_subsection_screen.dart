import 'package:applmsbm/model/subsection.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ImageSubsectionScreen extends StatelessWidget {
  static String routeName = "/image_subsection";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    return Scaffold(
      body: Body(),
    );
  }
}

class ImageDetailsArguments {
  final Subsection subsection;

  ImageDetailsArguments({required this.subsection});
}
