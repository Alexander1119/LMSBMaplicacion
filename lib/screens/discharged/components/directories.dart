import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Directories extends StatefulWidget {
  const Directories({Key? key}) : super(key: key);

  @override
  State<Directories> createState() => _DirectoriesState();
}

class _DirectoriesState extends State<Directories> {
  Future<List<Directory>?> listDirectories() async {
    List<Directory>? list;
    List<String> listString = [];
    // for (var i = 0; i < list!.length; i++) {
    //   listString[i] = (list[i].path.toString());
    // }
    return await getExternalStorageDirectories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listDirectories(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Text("No tiene archivos");
          } else {
            return Text(snapshot.data.toString());
          }
        });
  }
}
