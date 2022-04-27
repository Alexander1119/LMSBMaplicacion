import 'package:applmsbm/constants.dart';
import 'package:applmsbm/model/comment.dart';
import 'package:applmsbm/model/student.dart';
import 'package:applmsbm/model/subsection.dart';
import 'package:applmsbm/screens/quiz/components/screens/quizz_screen.dart';
import 'package:applmsbm/screens/quiz/components/ui/shared/color.dart';
import 'package:applmsbm/service/commentService.dart';
import 'package:applmsbm/service/studentService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsTabs extends StatefulWidget {
  Subsection subsection;
  OptionsTabs({required this.subsection}) : super();

  @override
  State<OptionsTabs> createState() => _OptionsTabsState();
}

class _OptionsTabsState extends State<OptionsTabs> {
  int? idPerson;
  Future<int?> getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    idPerson = await prefs.getInt('idPerson');
    print("el id encontrado es: " + idPerson.toString());
    return idPerson;
  }

  @override
  void initState() {
    getid();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: "Lista",
                ),
                Tab(
                  text: "Descripcion",
                ),
                Tab(
                  text: "Comentarios",
                ),
              ]),
          SizedBox(
            height: 300,
            child: TabBarView(children: [
              Icon(Icons.ac_unit_outlined),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        widget.subsection.description,
                        style: TextStyle(color: Colors.black),
                      ),
                      Expanded(
                        child: Center(
                          child: RawMaterialButton(
                            onPressed: () {
                              //Navigating the the Quizz Screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizzScreen(),
                                  ));
                            },
                            shape: const StadiumBorder(),
                            fillColor: AppColor.secondaryColor,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 24.0),
                              child: Text(
                                "Start the Quizz",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SafeArea(
                child: Column(
                  children: [
                    sendMessageArea(),
                    Column(
                      children: <Widget>[
                        Center(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: FutureBuilder(
                                  future: CommentService().commentsBySubsection(
                                      widget.subsection.idSubsection),
                                  builder: (BuildContext ctx,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.data == null) {
                                      print("no llego ninguna lista");
                                      return Container(
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    } else {
                                      return Column(
                                        children: [
                                          ...List.generate(
                                            snapshot.data.length,
                                            (index) {
                                              Comment comment =
                                                  snapshot.data[index];

                                              return message(comment);
                                            },
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget message(Comment comment) {
    return Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/lmsbm-28298.appspot.com/o/users%2Fuser.png?alt=media&token=713cb931-b03f-4d63-b1b0-a242b50a2317"),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          comment.comment,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black45,
          ),
        ),
      ],
    );
  }

  sendMessageArea() {
    TextEditingController mess = TextEditingController();
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: mess,
              decoration: InputDecoration.collapsed(
                hintText: 'Mensaje',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          FutureBuilder(
              future: getid(),
              builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  int idperson = snapshot.data;
                  return Container(
                    child: FutureBuilder(
                        future: StudentService().studentByPerson(idperson),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            Student student = snapshot.data;
                            return IconButton(
                              icon: Icon(Icons.send),
                              iconSize: 25,
                              color: kPrimaryColor,
                              onPressed: () {
                                CommentService().addCommet(mess.text.toString(),
                                    widget.subsection, student.idStudent);
                              },
                            );
                          }
                        }),
                  );
                }
              }),
        ],
      ),
    );
  }
}
