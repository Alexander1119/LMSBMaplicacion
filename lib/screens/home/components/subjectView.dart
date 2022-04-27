import 'package:flutter/material.dart';
import 'package:applmsbm/components/default_button.dart';
import 'package:applmsbm/model/person.dart';
import 'package:applmsbm/model/studyAreas.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/screens/home/components/sectionView.dart';
import 'package:applmsbm/service/studyAreasService.dart';
import 'package:applmsbm/service/teacherService.dart';
import '../../../constants.dart';

class SubjectView extends StatelessWidget {
  final Subject subject;

  const SubjectView({required this.subject}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 300,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //         image:  AssetImage('assets/logo_java.png'),
                      //         fit: BoxFit.cover
                      //     )
                      // ),
                      child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Center(
                          child: Image.network(subject.image,
                              fit: BoxFit.cover, width: 200),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            subject.subject,
                            style: TextStyle(
                                color: kPrimaryColor,
                                height: 1.4,
                                fontSize: 40),
                          ),
                        ),
                        Text(
                          subject.description,
                          style: TextStyle(color: kPrimaryColor, height: 1.4),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Maestro",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder(
                            future: TeacherService()
                                .getTeacherById(subject.teacher),
                            builder:
                                (BuildContext ctx, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                print("no tiene maestro");
                                return Container(
                                    child: Text(
                                  "no tiene maestro",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 16,
                                  ),
                                ));
                              } else {
                                Person person = snapshot.data;
                                return Text(
                                  person.name + " " + person.surName,
                                  style: TextStyle(color: kPrimaryColor),
                                );
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Area de estudio",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FutureBuilder(
                            future: StudyAreasService()
                                .getStudyAreaById(subject.studyAreas),
                            builder:
                                (BuildContext ctx, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                print("no tiene area de estudio");
                                return Container(
                                    child: Text(
                                  "no tiene maestro",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 16,
                                  ),
                                ));
                              } else {
                                StudyAreas person = snapshot.data;
                                return Text(
                                  person.studyAreas,
                                  style: TextStyle(color: kPrimaryColor),
                                );
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Contenido",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              makeVideo(image: 'assets/images/emma-1.jpg'),
                              makeVideo(image: 'assets/images/emma-2.jpg'),
                              makeVideo(image: 'assets/images/emma-3.jpg'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
          Positioned.fill(
            bottom: 50,
            child: Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white),
                  child: DefaultButton(
                    text: "Suscribirse",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SectionView(subject: subject),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget makeVideo({image}) {
    return AspectRatio(
      aspectRatio: 1.5 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.blue.withOpacity(.9),
            Colors.blue.withOpacity(.3)
          ])),
          child: Align(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 70,
            ),
          ),
        ),
      ),
    );
  }
}
