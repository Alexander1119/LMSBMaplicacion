import 'package:flutter/material.dart';

class ThirdTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 4,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              child: Image.network("https://firebasestorage.googleapis.com/v0/b/lmsbm-28298.appspot.com/o/content%2F1%2C1%2C1%2C1%2Cpartesfraccion%2Cimagen.jpg?alt=media&token=10601407-b258-4cca-9256-99cad77de36e")
            ),
          );
        });
  }
}
