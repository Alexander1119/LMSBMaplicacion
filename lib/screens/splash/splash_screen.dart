import 'package:applmsbm/connectivity_provider.dart';
import 'package:applmsbm/screens/splash/components/desconected.dart';
import 'package:flutter/material.dart';
import 'package:applmsbm/screens/splash/components/body.dart';
import 'package:applmsbm/size_config.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
