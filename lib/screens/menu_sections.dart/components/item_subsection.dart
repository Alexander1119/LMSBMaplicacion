import 'dart:io';

import 'package:applmsbm/constants.dart';
import 'package:applmsbm/model/section.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/model/subsection.dart';
import 'package:applmsbm/screens/menu_sections.dart/components/dowload.dart';
import 'package:applmsbm/screens/menu_sections.dart/components/view_model.dart';
import 'package:applmsbm/screens/subsection_audio/audio_subsection_screen.dart';

import 'package:applmsbm/screens/subsection_image/image_subsection_screen.dart';
import 'package:applmsbm/screens/subsection_video/video_subsection_screen.dart';
import 'package:applmsbm/service/subsectionService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as p;
import '../../../size_config.dart';

class ItemSubsection extends StatefulWidget {
  Subsection subsection;
  Subject subject;
  Section section;
  ItemSubsection(
      {required this.subsection, required this.subject, required this.section});

  @override
  State<ItemSubsection> createState() => _ItemSubsectionState();
}

class _ItemSubsectionState extends State<ItemSubsection> {
  late String typeFile;
  Icon getIcon() {
    var icons;
    Function onpressed;
    if (widget.subsection.idTypeContent == 1) {
      icons = Icons.play_circle_filled;
      typeFile = '.mp4';
    }
    if (widget.subsection.idTypeContent == 2) {
      icons = Icons.image;
      typeFile = '.jpg';
    }
    if (widget.subsection.idTypeContent == 3) {
      icons = Icons.multitrack_audio;
      typeFile = '.mp3';
    }

    return Icon(
      icons,
      color: kPrimaryColor,
      size: 30,
    );
    ;
  }

  Icon getIconView() {
    var icons;
    Function onpresed;
    if (widget.subsection.viewed == 1) {
      icons = Icons.check_circle;
    }
    if (widget.subsection.viewed == 2) {
      icons = Icons.check_circle_outline;
    }

    return Icon(
      icons,
      color: kViewColor,
    );
    ;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
        child: Padding(
      padding: EdgeInsets.only(
        bottom: getProportionateScreenWidth(10),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  spreadRadius: 20,
                  blurRadius: 10,
                  offset: Offset(0, 10))
            ],
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Center(
                child: getIconView(),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 55,
                height: 55,
                child: IconButton(
                    onPressed: () {
                      if (widget.subsection.idTypeContent == 1) {
                        Navigator.pushNamed(
                          context,
                          VideoSubsectionScreen.routeName,
                          arguments: VideoDetailsArguments(
                              subsection: widget.subsection),
                        );
                      }
                      if (widget.subsection.idTypeContent == 2) {
                        Navigator.pushNamed(
                          context,
                          ImageSubsectionScreen.routeName,
                          arguments: ImageDetailsArguments(
                              subsection: widget.subsection),
                        );
                      }
                      if (widget.subsection.idTypeContent == 3) {
                        Navigator.pushNamed(
                          context,
                          AudioSubsectionScreen.routeName,
                          arguments: AudioDetailsArguments(
                              subsection: widget.subsection),
                        );
                      }
                    },
                    icon: getIcon()),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: kPrimaryColor,
                    width: 5,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Flexible(
                child: Container(
                  height: 55,
                  width: 150,
                  child: Text(
                    widget.subsection.subsection,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Dowload(
                  nameFile: widget.subsection.subsection + typeFile,
                  subject: widget.subject,
                  section: widget.section,
                  subsection: widget.subsection),

              // IconButton(
              //     onPressed: () {
              //       dowloadAndSaveFileToStorage(widget.subsection.pathFile,
              //           widget.subsection.subsection + typeFile);
              //       MyViewModel().startDownloading();

              //     },
              //     icon: Icon(Icons.download)),
            ],
          ),
        ),
      ),
    ));
  }
}
