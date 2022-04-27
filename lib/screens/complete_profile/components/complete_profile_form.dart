import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:applmsbm/components/data_picker.dart';
import 'package:applmsbm/helper/keyboard.dart';
import 'package:applmsbm/model/person.dart';
import 'package:applmsbm/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:applmsbm/components/custom_surfix_icon.dart';
import 'package:applmsbm/components/default_button.dart';
import 'package:applmsbm/components/form_error.dart';
import 'package:applmsbm/screens/otp/otp_screen.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  Person person;
  CompleteProfileForm({required this.person});
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? name;
  String? surName;
  String? birthday;
  String? gender;
  List genderitem = ["Masculino", "Femenino"];

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildGenderForm(),
          SizedBox(height: getProportionateScreenHeight(30)),
          dateBirthday(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                Signup();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildGenderForm() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 60,
          padding: EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(25)),
          child: DropdownButton(
            value: gender,
            onChanged: (newValue) {
              setState(() {
                gender = newValue.toString();
              });
            },
            items: genderitem.map((valueItem) {
              return DropdownMenuItem(
                child: Text(valueItem),
                value: valueItem,
              );
            }).toList(),
            hint: Text("Selecciones su genero"),
            dropdownColor: Colors.grey,
            iconSize: 36,
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: true,
            underline: SizedBox(),
          ),
        ),
      ),
    );
  }
  // TextFormField buildGenderFormField() {
  //   return Center(
  //     child: DropdownButton(value: gender, onChanged: ,),
  //   );

  // return TextFormField(
  //   onSaved: (newValue) => gender = newValue,
  //   onChanged: (value) {
  //     if (value.isNotEmpty) {
  //       removeError(error: kAddressNullError);
  //     }
  //     return null;
  //   },
  //   validator: (value) {
  //     if (value!.isEmpty) {
  //       addError(error: kAddressNullError);
  //       return "";
  //     }
  //     return null;
  //   },
  //   decoration: InputDecoration(
  //     labelText: "Genero",
  //     hintText: "Ingrese su genero",
  //     // If  you are using latest version of flutter then lable text and hint text shown like this
  //     // if you r using flutter less then 1.20.* then maybe this is not working properly
  //     floatingLabelBehavior: FloatingLabelBehavior.always,
  //     suffixIcon:
  //         CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
  //   ),
  // );
  // }

  TextFormField buildBirthdayFormField() {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      onSaved: (newValue) => birthday = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Fecha de nacimiento",
        hintText: "Ingrese su fecha de nacimiento",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  Widget dateBirthday() {
    DateTime dateTime = DateTime.now();
    bool enableicon = false;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  child: TextFormField(
                    enabled: enableicon,
                    showCursor: false,
                    enableInteractiveSelection: false,
                    decoration: InputDecoration(
                      label: Text(
                        dateTime == null
                            ? 'Fecha de nacimiento'
                            : dateTime.year.toString() +
                                " - " +
                                dateTime.month.toString() +
                                " - " +
                                dateTime.day.toString(),
                        style: TextStyle(color: Colors.black),
                      ),
                      hintStyle: TextStyle(fontSize: 20),
                      filled: true,
                      fillColor: Color(0xffffffff),
                      prefixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffffffff)),
                          borderRadius: BorderRadius.circular(50)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffffffff)),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    DateTime? dataTime2 = await showDatePicker(
                        context: context,
                        initialDate: dateTime,
                        firstDate: DateTime(1800),
                        lastDate: DateTime(3000));

                    if (dataTime2 != null) {
                      setState(() {
                        dateTime = dataTime2;
                        birthday = dateTime.year.toString() +
                            "-" +
                            dateTime.month.toString() +
                            "-" +
                            dateTime.day.toString();
                      });
                    }
                  },
                  icon:
                      Icon(Icons.calendar_today_outlined, color: Colors.black),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => surName = newValue,
      decoration: InputDecoration(
        labelText: "Apellido(s)",
        hintText: "Ingrese su apellido",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nombre(s)",
        hintText: "Ingrese su nombre",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  Future<void> Signup() async {
    print("    email': " +
        widget.person.email.toString() +
        "   " +
        'password' +
        widget.person.password.toString() +
        "   " +
        'name: ' +
        name.toString() +
        "   " +
        'surName' +
        surName.toString() +
        "   " +
        'gender' +
        gender.toString() +
        "   " +
        'date' +
        birthday.toString());

    var response = await http.post(
        Uri.parse("http://10.0.2.2:8080//person/addPersonStudent"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': widget.person.email.toString(),
          'password': widget.person.password.toString(),
          'name': name.toString(),
          'surName': surName.toString(),
          'gender': gender.toString(),
          'date': birthday.toString(),
          'image': "image",
          'status': "1",
        }));
    var responseData = json.decode(response.body);
    Person person = Person(
        idPerson: responseData['idPerson'],
        name: responseData['name'],
        surName: responseData['surName'],
        email: responseData['email'],
        password: responseData['password'],
        image: responseData['image'],
        status: responseData['status'],
        date: responseData['date'],
        gender: responseData['gender']);

    if (person != null) {
      KeyboardUtil.hideKeyboard(context);
      Navigator.pushNamed(context, HomeScreen.routeName);
      saveId(person.idPerson);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text("Credenciales invalidos"),
        duration: Duration(milliseconds: 2500),
      ));
    }
  }

  Future<void> saveId(int id) async {
    print("Guardando ID: " + id.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('idPerson', id);
  }
}
