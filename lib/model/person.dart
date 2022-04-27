class Person {
  int idPerson;
  String name;
  String surName;
  String date;
  String gender;
  String email;
  String password;
  String image;
  int status;

  Person({
    required this.idPerson,
    required this.name,
    required this.surName,
    required this.date,
    required this.gender,
    required this.email,
    required this.password,
    required this.image,
    required this.status,
  });

  Person.fromJson(Map<String, dynamic> json)
      : idPerson = json['idPerson'],
        name = json['name'],
        surName = json['surName'],
        email = json['email'],
        password = json['password'],
        image = json['image'],
        status = json['status'],
        date = json['date'],
        gender = json['gender'];
}
