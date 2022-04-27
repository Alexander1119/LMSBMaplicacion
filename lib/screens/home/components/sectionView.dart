import 'package:flutter/material.dart';
import 'package:applmsbm/model/section.dart';
import 'package:applmsbm/screens/home/video/pages/home.dart';
import 'package:applmsbm/service/sectionService.dart';

import '../../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:applmsbm/model/subject.dart';

class SectionView extends StatelessWidget {
  final Subject subject;

  const SectionView({required this.subject}) : super();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                        top: size.height * .12,
                        left: size.width * .1,
                        right: size.width * .1),
                    height: size.height * .48,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage("assets/bg.png"),
                      //   fit: BoxFit.fitWidth,
                      // ),
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Center(
                      child: Image.network(subject.image),
                    )),
                Padding(
                    padding: EdgeInsets.only(top: size.height * .48 - 20),
                    child: FutureBuilder(
                      future: SectionService()
                          .getSectionsBySubject(subject.id_subject),
                      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          print("no llego ninguna lista");
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          print("la lista si llego");
                          return ListView.builder(
                            itemCount: snapshot.data.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(16),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Section section = snapshot.data[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          UserHomePage(section: section),
                                    ),
                                  );
                                },
                                child: ProfileMenu(
                                    text: section.section,
                                    icon: 'assets/icons/Question mark.svg'),
                              );
                            },
                          );
                        }
                      },
                    )),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // RichText(
                  //   text: TextSpan(
                  //     style: Theme.of(context).textTheme.headline5,
                  //     children: [
                  //       TextSpan(
                  //         text: "You might also ",
                  //       ),
                  //       TextSpan(
                  //         text: "like….",
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       height: 180,
                  //       width: double.infinity,
                  //     ),
                  //     Positioned(
                  //       bottom: 0,
                  //       left: 0,
                  //       right: 0,
                  //       child: Container(
                  //         padding:
                  //             EdgeInsets.only(left: 24, top: 24, right: 150),
                  //         height: 160,
                  //         width: double.infinity,
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(29),
                  //           color: Color(0xFFFFF8F9),
                  //         ),
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             RichText(
                  //               text: TextSpan(
                  //                 style: TextStyle(color: kBlackColor),
                  //                 children: [
                  //                   TextSpan(
                  //                     text:
                  //                         "How To Win \nFriends & Influence \n",
                  //                     style: TextStyle(
                  //                       fontSize: 15,
                  //                     ),
                  //                   ),
                  //                   TextSpan(
                  //                     text: "Gary Venchuk",
                  //                     style: TextStyle(color: kLightBlackColor),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //             // Row(
                  //             //   children: <Widget>[
                  //             //     BookRating(
                  //             //       score: 4.9,
                  //             //     ),
                  //             //     SizedBox(width: 10),
                  //             //     Expanded(
                  //             //       child: RoundedButton(
                  //             //         text: "Read",
                  //             //         verticalPadding: 10,
                  //             //       ),
                  //             //     ),
                  //             //   ],
                  //             // )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     // Positioned(
                  //     //   top: 0,
                  //     //   right: 0,
                  //     //   child: Image.asset(
                  //     //     "assets/images/book-3.png",
                  //     //     width: 150,
                  //     //     fit: BoxFit.fitWidth,
                  //     //   ),
                  //     // ),
                  //   ],
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget chapterCard(Section section) {
//   print(section.section);

//   return Container(
//     padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//     margin: EdgeInsets.only(bottom: 16),
//     width: 100,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(38.5),
//       boxShadow: [
//         BoxShadow(
//           offset: Offset(0, 10),
//           blurRadius: 33,
//           color: Color(0xFFD3D3D3).withOpacity(.84),
//         ),
//       ],
//     ),
//     child: Row(
//       children: <Widget>[
//         RichText(
//           textAlign: TextAlign.center,
//           text: TextSpan(
//             children: [
//               TextSpan(
//                 text: section.section + "\n",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: kBlackColor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               // TextSpan(
//               //   text: section.description,
//               //   style: TextStyle(color: kLightBlackColor),
//               // ),
//             ],
//           ),
//         ),
//         Spacer(),
//         IconButton(
//           icon: Icon(
//             Icons.arrow_forward_ios,
//             size: 18,
//           ),
//           onPressed: () {},
//         )
//       ],
//     ),
//   );
// }

// class BookInfo extends StatelessWidget {
//   const BookInfo({
//     Key key,
//     this.size,
//   }) : super(key: key);

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Flex(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         direction: Axis.horizontal,
//         children: <Widget>[
//           Expanded(
//               flex: 1,
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Crushing &",
//                       style: Theme.of(context)
//                           .textTheme
//                           .headline4
//                           .copyWith(fontSize: 28),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: this.size.height * .005),
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.only(top: 0),
//                     child: Text(
//                       "Influence",
//                       style: Theme.of(context).textTheme.subtitle1.copyWith(
//                             fontSize: 25,
//                             fontWeight: FontWeight.bold,
//                           ),
//                     ),
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Container(
//                             width: this.size.width * .3,
//                             padding:
//                                 EdgeInsets.only(top: this.size.height * .02),
//                             child: Text(
//                               "When the earth was flat andeveryone wanted to win the gameof the best and people and winning with an A game with all the things you have.",
//                               maxLines: 5,
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 color: kLightBlackColor,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             margin:
//                                 EdgeInsets.only(top: this.size.height * .015),
//                             padding: EdgeInsets.only(left: 10, right: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: FlatButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "Read",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                       Column(
//                         children: <Widget>[
//                           IconButton(
//                             icon: Icon(
//                               Icons.favorite_border,
//                               size: 20,
//                               color: Colors.grey,
//                             ),
//                             onPressed: () {},
//                           ),
//                           BookRating(score: 4.9),
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               )),
//           Expanded(
//               flex: 1,
//               child: Container(
//                 color: Colors.transparent,
//                 child: Image.asset(
//                   "assets/images/book-1.png",
//                   height: double.infinity,
//                   alignment: Alignment.topRight,
//                   fit: BoxFit.fitWidth,
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }
class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: EdgeInsets.all(20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: kPrimaryColor,
              width: 22,
            ),
            SizedBox(width: 20),
            Expanded(
                child: Text(text,
                    style: TextStyle(color: Colors.black, fontSize: 20))),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
