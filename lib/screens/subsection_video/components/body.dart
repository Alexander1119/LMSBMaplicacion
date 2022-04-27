import 'package:applmsbm/model/subsection.dart';
import 'package:applmsbm/screens/subsection_video/components/option_tabs.dart';
import 'package:applmsbm/screens/subsection_video/components/video_subcontent.dart';

import 'package:applmsbm/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  Subsection subsection;
  Body({required this.subsection});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              VideoSubcontent(subsection: subsection),
              OptionsTabs(
                subsection: subsection,
              )
            ],
          ),
        ),
      ),
    );
  }
}
