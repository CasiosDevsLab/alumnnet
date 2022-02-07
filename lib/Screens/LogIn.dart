import 'package:alumnnet/Class/User.dart';
import 'package:alumnnet/Screens/SignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formkeyMail = GlobalKey<FormState>();
  final _formkeyPwd = GlobalKey<FormState>();
  final User user = User();

  void logIn() {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => Home(
                  user: this.user,
                )));
  }

  void registration() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) => new SignIn()));
  }

  bool checkCreds() {
    return _formkeyMail.currentState!.validate() &&
        _formkeyPwd.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    String pwd = "";

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    final Gradient gradient = LinearGradient(
      colors: <Color>[
        Colors.blue,
        Colors.blue[700] as Color,
        Colors.blue[900] as Color,
        Colors.indigo[900] as Color,
      ],
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: width * 0.6,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Image.asset("logo.png", height: 100),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
                    child: Text(
                      "AlumnNet",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                        color: Colors.indigo[900] as Color,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,
                            offset: Offset(1, 6),
                          ),
                        ]),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Form(
                      key: _formkeyMail,
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email Adresse ist leider ungültig";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'E-Mail',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          }),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(1, 6),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Form(
                      key: _formkeyPwd,
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Dein Password ist leider nicht gültig";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.send,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Passwort',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              pwd = value;
                            });
                          }),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Passwort vergessen",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          )),
                    )
                  ]),
                  Container(
                    width: width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ],
                      gradient: gradient,
                    ),
                    child: FlatButton(
                        onPressed: () {
                          if (this.checkCreds()) {
                            this.logIn();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Anmelden",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            this.registration();
                          },
                          child: Text(
                            "Registriere dich hier",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
