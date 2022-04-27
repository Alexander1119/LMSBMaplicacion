import 'package:applmsbm/model/subsection.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'components/body.dart';

class AudioSubsectionScreen extends StatelessWidget {
  static String routeName = "/audio_subsection";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    return Scaffold(
      body: Body(),
    );
  }
}

class AudioDetailsArguments {
  final Subsection subsection;

  AudioDetailsArguments({required this.subsection});
}
