import 'package:alumnnet/Class/AnimatedController.dart';
import 'package:alumnnet/Class/User.dart';
import 'package:flutter/material.dart';

import 'Userdata/Userdata.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _key = GlobalKey();

  final _vornameTextController = TextEditingController();
  final _nachnameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _password2TextController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _vornameTextController,
      _nachnameTextController,
      _emailTextController,
      _passwordTextController,
      _password2TextController
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  void next(User user) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Userdata(user: user)));
  }

  bool checkReg() {
    return _key.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.5, vertical: height * 0.1),
          child: Form(
            key: _key,
            onChanged: _updateFormProgress,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "logo.png",
                  height: height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.03, bottom: height * 0.05),
                  child: const Text(
                    "AlumniNet",
                    style: TextStyle(
                        color: Color.fromRGBO(34, 46, 106, 1),
                        fontWeight: FontWeight.w100,
                        fontSize: 30),
                  ),
                ),
                AnimatedProgressIndicator(value: _formProgress),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.03),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(3, 3),
                              ),
                            ]),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Bitte gib uns deinen Vornamen";
                              }
                              return null;
                            },
                            controller: _vornameTextController,
                            decoration: const InputDecoration(
                              labelText: "Vorname",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: height * 0.03),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(3, 3),
                              ),
                            ]),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Bitte gib uns deinen Nachnamen";
                              }
                              return null;
                            },
                            controller: _nachnameTextController,
                            decoration: const InputDecoration(
                              labelText: "Nachname",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.03),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Bitte gib uns deine E-Mail Adresse";
                        }
                        return null;
                      },
                      controller: _emailTextController,
                      decoration: const InputDecoration(
                        labelText: "E-Mail",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.03),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Dein Passwort darf nicht leer sein";
                        } else if (value.length < 6) {
                          return "Dein Passwort muss mindestens 6 Zeichen haben";
                        }
                        return null;
                      },
                      controller: _passwordTextController,
                      decoration: const InputDecoration(
                        labelText: "Passwort",
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: height * 0.03),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(3, 3),
                        ),
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextFormField(
                      validator: (value) {
                        if (value != _passwordTextController.text) {
                          return "Passwörter stimmen nicht überein";
                        }
                        return null;
                      },
                      controller: _password2TextController,
                      decoration: const InputDecoration(
                        labelText: "Passwort wiederholen",
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
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
                        if (checkReg()) {
                          User user = User.withData(
                              id: 0,
                              vorname: _vornameTextController.text,
                              nachname: _nachnameTextController.text,
                              mail: _emailTextController.text,
                              position: "",
                              firma: "",
                              alter: 0);
                          user.setName(_vornameTextController.text,
                              _nachnameTextController.text);
                          next(user);
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "weiter",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Ich habe bereits ein Konto",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
