import 'dart:io';
import 'dart:ui';
import 'package:applmsbm/components/progress_painter.dart';
import 'package:applmsbm/model/section.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/model/subsection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class Dowload extends StatefulWidget {
  String nameFile;
  Subject subject;
  Section section;
  Subsection subsection;
  Dowload(
      {required this.nameFile,
      required this.subject,
      required this.section,
      required this.subsection})
      : super();

  @override
  State<Dowload> createState() => _DowloadState();
}

class _DowloadState extends State<Dowload> {
  late Dio dio;

  late double porcentaje;
  late bool progressDone;

  @override
  void initState() {
    dio = Dio();
    super.initState();
    porcentaje = 0;
    progressDone = false;
  }

  Future<List<Directory>?> getExternaStoragePath() {
    return p.getExternalStorageDirectories(type: p.StorageDirectory.downloads);
  }

  Future dowloadAndSaveFileToStorage() async {
    try {
      // await pr.show();
      final dirlist = await getExternaStoragePath();
      final path = dirlist![0].path +
          "/" +
          widget.subject.subject +
          "/" +
          widget.section.section +
          "/";
      final file = File('$path/${widget.nameFile}');
      await dio.download(widget.subsection.pathFile, file.path,
          onReceiveProgress: (rec, total) {
        setState(() {
          progressDone = false;
          porcentaje = ((rec / total) * 100);
          print(porcentaje);

          //   pr.update(message: "Cargando :  $progress");
        });
      });

      // pr.hide();
      var fileFullPath = file.path;
      print(fileFullPath);
    } catch (e) {
      print(e);
    }

    setState(() {
      progressDone = true;
    });
  }

  Widget getProgressText() {
    return Text(
      porcentaje.toString().substring(1, 3),
      style: TextStyle(fontSize: 12, color: Colors.black),
    );
  }

  Widget progressView() {
    return CustomPaint(
      child: Center(
          child: progressDone
              ? Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.green,
                )
              : getProgressText()),
      foregroundPainter: ProgressPainter(
          defaultCircleColor: Colors.amber,
          percentageCompletedCircleColor: Colors.green,
          completedPercentage: porcentaje,
          circleWidth: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              dowloadAndSaveFileToStorage();
            },
            icon: Icon(
              Icons.download,
              size: 20,
            )),
        progressView(),
      ],
    );
  }
}
