import 'package:applmsbm/model/person.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";

  @override
  Widget build(BuildContext context) {
    final StudentProfileArguments agrs =
        ModalRoute.of(context)!.settings.arguments as StudentProfileArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(person: agrs.person),
    );
  }
}

class StudentProfileArguments {
  final Person person;

  StudentProfileArguments({required this.person});
}
