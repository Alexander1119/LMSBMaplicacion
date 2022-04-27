import 'package:applmsbm/constants.dart';
import 'package:applmsbm/model/person.dart';
import 'package:applmsbm/model/section.dart';
import 'package:applmsbm/model/subject.dart';
import 'package:applmsbm/screens/menu_sections.dart/components/content.dart';
import 'package:applmsbm/service/teacherService.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class MainWidget extends StatefulWidget {
  MainWidget({required this.sections, required this.subject}) : super();

  final List<Section> sections;
  final Subject subject;
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  late KFDrawerController _drawerController;

  List<KFDrawerItem> getSections() {
    List<Section> sections = widget.sections;
    Subject subject = widget.subject;
    List<KFDrawerItem> items = [];

    for (var i = 0; i < sections.length; i++) {
      items.add(KFDrawerItem.initWithPage(
        text: Text(
          sections[i].section,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        icon: Icon(Icons.account_box, color: Colors.white),
        page: Content(section: sections[i], subject: subject),
      ));
    }
    return items;
  }

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
        initialPage: Content(
          section: widget.sections[0],
          subject: widget.subject,
        ),
        items: getSections());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 150,
                  child: Hero(
                    tag: widget.subject.id_subject.toString(),
                    child: Image.network(widget.subject.image),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.subject.subject,
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                    const SizedBox(height: 2),
                    FutureBuilder(
                        future: TeacherService()
                            .getTeacherById(widget.subject.teacher),
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            Person person = snapshot.data;
                            return Text(
                              person.name + " " + person.surName,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            );
                          }
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
        footer: KFDrawerItem(
          text: Text(
            'Logout',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [kPrimaryColor, kPrimaryColor],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
