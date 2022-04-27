import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../size_config.dart';
import 'package:http/http.dart' as http;
import 'package:applmsbm/model/person.dart';
import 'package:applmsbm/service/personService.dart';

class DiscountBanner extends StatefulWidget {
  DiscountBanner({Key? key}) : super(key: key);

  @override
  _DiscountBannerState createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner> {
  int? idPerson;

  Future<int?> getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    idPerson = await prefs.getInt('idPerson');
    print("el id encontrado es: " + idPerson.toString());
    return idPerson;
  }

  @override
  void initState() {
    // TODO: implement initState
    getid();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 90,
      width: double.infinity,
      margin: EdgeInsets.all(getProportionateScreenWidth(20)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: FutureBuilder(
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
                    future: PersonService().getPersonById(idperson),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        Person person = snapshot.data;
                        return Text.rich(
                          TextSpan(
                            style: TextStyle(color: Colors.white),
                            children: [
                              TextSpan(text: "Hola!\n"),
                              TextSpan(
                                text: person.name + " " + person.surName,
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              );
            }
          }),
    );
  }
}
