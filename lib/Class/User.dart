import 'package:flutter/cupertino.dart';

class User {
  late String vorname, nachname, description = "";
  late String position;
  late String mail;
  late String firma = "";
  late int id;
  late int alter;

  List<String> interessen = [];
  List<String> erfahrungen = [];

  ImageProvider<Object>? profileImage = Image.asset(
    "user.png",
  ).image;

  User();

  User.withData(
      {required this.id,
      required this.vorname,
      required this.nachname,
      required this.mail,
      required this.position,
      required this.firma,
      required this.alter});

  get usersName => vorname + " " + nachname;

  setName(vorname, nachname) =>
      {this.vorname = vorname, this.nachname = nachname};

  setAge(alter) => this.alter = alter;

  setInterests(interessen) => this.interessen = interessen;

  setProfileImage(image) => this.profileImage = image;

  void initUser() {}
}
