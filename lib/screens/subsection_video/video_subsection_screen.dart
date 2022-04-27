import 'package:applmsbm/model/subsection.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'components/body.dart';

class VideoSubsectionScreen extends StatelessWidget {
  static String routeName = "/video_subsection";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    final VideoDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as VideoDetailsArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Video"),
      ),
      body: Body(
        subsection: agrs.subsection,
      ),
    );
  }
}

class VideoDetailsArguments {
  final Subsection subsection;

  VideoDetailsArguments({required this.subsection});
}
