import 'package:applmsbm/components/coustom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';
import 'components/body.dart';

class DischargedScreen extends StatelessWidget {
  static String routeName = "/discharged";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Descargas",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: Body(),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.discharged),
    );
  }
}
