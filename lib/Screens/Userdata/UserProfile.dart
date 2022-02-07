import 'package:alumnnet/Class/User.dart';
import 'package:alumnnet/Screens/Chat.dart';
import 'package:alumnnet/Screens/Home.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool follows = false;

  void toHomeScreen() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void toChat(User user) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            Chat(thisUser: user, otherUser: user)));
  }

  @override
  Widget build(BuildContext context) {
    User user = widget.user;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                toHomeScreen();
              },
              child: const Text(
                "AlumniNet",
                style: TextStyle(
                    color: Color.fromRGBO(34, 46, 106, 1),
                    fontWeight: FontWeight.w100,
                    fontSize: 30),
              ),
            ),
          ),
        ],
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
                  maxRadius: height * 0.18,
                ),
              ),
              Text(
                user.usersName,
                style: TextStyle(
                  fontSize: height * 0.05,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.position + " bei " + user.firma,
                    style: TextStyle(fontSize: height * 0.025),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: width * 0.25,
                  child: Text(
                    user.description,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: user.id == 0
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: width * 0.1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(3, 3),
                                ),
                              ],
                              color: follows ? Colors.white : null,
                              gradient: follows ? null : gradient,
                            ),
                            child: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    follows = !follows;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32)),
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    follows
                                        ? "Du folgst " + user.vorname
                                        : user.vorname + " folgen",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: follows
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          Container(
                            width: width * 0.1,
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
                                  setState(() {
                                    toChat(user);
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32)),
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "Nachricht an " + user.vorname,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      ),
              ),
              Text(
                "Interessen von " + user.vorname,
                style: TextStyle(fontSize: height * 0.025),
              ),
              SizedBox(
                height: height * 0.6,
                width: width * 0.6,
                child: ListView.builder(
                  itemCount: user.interessen.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: Center(child: Text(user.interessen[index])));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
