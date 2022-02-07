import 'package:alumnnet/Class/AnimatedController.dart';
import 'package:alumnnet/Class/User.dart';
import 'package:alumnnet/Screens/Userdata/Descripton.dart';
import 'package:flutter/material.dart';

import '../Home.dart';

class Userdata extends StatefulWidget {
  const Userdata({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  _UserdataState createState() => _UserdataState();
}

class _UserdataState extends State<Userdata> {
  final _textField = TextEditingController();
  final GlobalKey<FormState> _validator = GlobalKey();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _textField,
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
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Description(
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
                      "Moin " +
                          user.vorname +
                          ",\n" +
                          "teile gerne ein paar deiner Interessen mit unserer Community",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color.fromRGBO(34, 46, 106, 1),
                          fontWeight: FontWeight.w100,
                          fontSize: height * 0.04),
                    ),
                  ),
                ),
                AnimatedProgressIndicator(value: _formProgress),
                SizedBox(
                  height: height * 0.3,
                  child: ListView.builder(
                      itemCount: user.interessen.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            user.interessen.removeAt(index);
                            _updateFormProgress();
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: height * 0.01,
                                horizontal: width * 0.3),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: Text(
                                user.interessen[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.02),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
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
                                return "Du musst zunächst etwas eingeben";
                              }
                              return null;
                            },
                            controller: _textField,
                            decoration: const InputDecoration(
                              labelText: "Gib hier deine Interessen ein",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => gradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                          onPressed: () {
                            setState(() {
                              if (checkText()) {
                                user.interessen.add(_textField.text);
                                _updateFormProgress();
                                _textField.clear();
                              }
                            });
                          },
                          child: const Icon(Icons.send, color: Colors.white)),
                    )
                  ],
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
                        if (user.interessen.isNotEmpty) {
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
