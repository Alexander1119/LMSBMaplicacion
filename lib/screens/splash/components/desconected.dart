import 'package:flutter/material.dart';

class Desconected extends StatelessWidget {
  const Desconected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("No tienes conexio a internet"),
      ),
    );
  }
}
