import 'package:alumnnet/Class/AnimatedController.dart';
import 'package:alumnnet/Class/User.dart';
import 'package:flutter/material.dart';

import '../Home.dart';

class Description extends StatefulWidget {
  const Description({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final _controllerDescription = TextEditingController();
  final _controllerPosition = TextEditingController();
  final _controllerFirma = TextEditingController();
  final GlobalKey<FormState> _validator = GlobalKey();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _controllerDescription,
      _controllerPosition,
      _controllerFirma
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

  void _goToHome(User user) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Home(
              user: user,
            )));
  }

  bool checkText() {
    return _validator.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    final User user = widget.user;

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
            key: _validator,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.03, bottom: height * 0.05),
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => gradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      "Beschreibe dich selbst in zwei kurzen Sätzen \nfür unsere Community",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color.fromRGBO(34, 46, 106, 1),
                          fontWeight: FontWeight.w100,
                          fontSize: height * 0.04),
                    ),
                  ),
                ),
                AnimatedProgressIndicator(value: _formProgress),
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
                          return "Du musst zunächst etwas eingeben";
                        }
                        return null;
                      },
                      controller: _controllerDescription,
                      decoration: const InputDecoration(
                        labelText: "Gib hier deine Beschreibung ein",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => {
                        setState(() {
                          
                            user.description = _controllerDescription.text;
                            _updateFormProgress();
                          
                        })
                      },
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
                          return "Du musst zunächst etwas eingeben";
                        }
                        return null;
                      },
                      controller: _controllerPosition,
                      decoration: const InputDecoration(
                        labelText: "Gib hier deine Position ein",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => {
                        setState(() {
                          
                            user.position = _controllerPosition.text;
                            _updateFormProgress();
                          
                        })
                      },
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
                          return "Du musst zunächst etwas eingeben";
                        }
                        return null;
                      },
                      controller: _controllerFirma,
                      decoration: const InputDecoration(
                        labelText: "Gib hier deine Firma ein",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => {
                        setState(() {
                          
                            user.firma = _controllerFirma.text;
                            _updateFormProgress();
                          
                        })
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
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
                        if (this.checkText()) {
                          _controllerDescription.clear();
                          _controllerPosition.clear();
                          _controllerFirma.clear();
                          _goToHome(user);
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
