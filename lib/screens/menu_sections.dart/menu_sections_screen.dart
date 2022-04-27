import 'package:applmsbm/model/section.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/screens/menu_sections.dart/components/menu_sections.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class MenuSectionsScreen extends StatelessWidget {
  static String routeName = "/menu_sections";

  @override
  Widget build(BuildContext context) {
    final MenuSectionsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as MenuSectionsArguments;

    return Scaffold(body: Body(subject: agrs.subject, sections: agrs.sections));
  }
}

class MenuSectionsArguments {
  final Subject subject;
  final List<Section> sections;

  MenuSectionsArguments({required this.subject, required this.sections});
}
