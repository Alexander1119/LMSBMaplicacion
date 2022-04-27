import 'package:flutter/material.dart';
import 'package:applmsbm/components/coustom_bottom_nav_bar.dart';
import 'package:applmsbm/enums.dart';
import 'package:applmsbm/model/person.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
