import 'package:alumnnet/Class/User.dart';
import 'package:alumnnet/Screens/Home.dart';
import 'package:flutter/material.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _UserSettingsState createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    User user = widget.user;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final TextEditingController controllerVorname =
        new TextEditingController(text: user.vorname);
    final TextEditingController controllerNachname =
        new TextEditingController(text: user.nachname);

    final TextEditingController controllerBeschreibung =
        new TextEditingController(text: user.description);
    final TextEditingController controllerFirma =
        new TextEditingController(text: user.firma);
    final TextEditingController controllerEMail =
        new TextEditingController(text: user.mail);
    final TextEditingController controllerPosition =
        new TextEditingController(text: user.position);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backwardsCompatibility: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  backgroundImage: user.profileImage,
                  maxRadius: height * 0.2,
                ),
              ),
              Text(user.usersName),
              Text(user.position),
              Text(user.firma),
              Text(user.description),
              SizedBox(
                height: height * 0.6,
                width: width * 0.6,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text("Vorname *"),
                            subtitle: TextField(
                              onChanged: (value) {
                                user.vorname = value;
                              },
                              onEditingComplete: () {
                                setState(() {});
                              },
                              controller: controllerVorname,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text("Nachname *"),
                            subtitle: TextField(
                              controller: controllerNachname,
                              onChanged: (value) {
                                user.nachname = value;
                              },
                              onEditingComplete: () {
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                        title: Text("Position"),
                        subtitle: TextField(
                          controller: controllerPosition,
                          onChanged: (value) {
                            user.position = value;
                          },
                          onEditingComplete: () {
                            setState(() {});
                          },
                        )),
                    ListTile(
                        title: Text("Firma"),
                        subtitle: TextField(
                          controller: controllerFirma,
                          onChanged: (value) {
                            user.firma = value;
                          },
                          onEditingComplete: () {
                            setState(() {});
                          },
                        )),
                    ListTile(
                      title: Text("Deine Profilbeschreibung"),
                      subtitle: TextField(
                        controller: controllerBeschreibung,
                        onChanged: (value) {
                          user.description = value;
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                    ),
                    Text("Deine Interessen"),
                    SizedBox(
                      height: height * user.interessen.length / 10,
                      child: ListView.builder(
                          itemCount: user.interessen.length,
                          itemBuilder: (context, index) {
                            if (user.interessen.isEmpty) {
                              return Text(
                                  "Du hast noch keine Interessen gepflegt");
                            } else {
                              return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    setState(() {
                                      user.interessen.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(15),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(32),
                                          color: Colors.white,
                                          boxShadow: const <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5,
                                              offset: Offset(3, 3),
                                            ),
                                          ]),
                                      child: Text(
                                        user.interessen[index],
                                        textAlign: TextAlign.center,
                                      )));
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
