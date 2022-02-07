import 'package:alumnnet/Class/Message.dart';
import 'package:alumnnet/Class/User.dart';
import 'package:alumnnet/Screens/Userdata/UserProfile.dart';
import 'package:alumnnet/Widgets/MessageWidget.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key, required this.thisUser, required this.otherUser})
      : super(key: key);
  final User thisUser, otherUser;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _textField = TextEditingController();
  final GlobalKey<ScaffoldState> _drawer = new GlobalKey<ScaffoldState>();
  User otherUser = User.withData(
        id: 0,
        vorname: "Gerrit",
        nachname: "Remané",
        mail: "gerritmail@mail.de",
        position: "Dozent",
        firma: "FH Wedel",
        alter: 34,
      ),
      thisUser = User.withData(
          id: 1,
          vorname: "Lennart",
          nachname: "Behrendt",
          position: "Alumni",
          firma: "Tchibo",
          mail: "lennart@gmail.com",
          alter: 24);

  bool read = true;

  late List<Message> messages = [
    new Message("Moin Lennart!", otherUser, thisUser),
    new Message("Wie geht's dir?", otherUser, thisUser),
  ];

  late String senderPrefix =
      messages.last.sender.id == thisUser.id ? "Du" : otherUser.vorname;

  @override
  void initState() {
    super.initState();
    setState(() {
      otherUser.profileImage = Image.asset("pb.jpg").image;
    });
  }

  Widget build(BuildContext context) {
    User thisUser = widget.thisUser;
    User otherUser = widget.otherUser;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    final Gradient gradient = LinearGradient(
      colors: <Color>[
        Colors.blue.withOpacity(0.9),
        Colors.blue[700]!.withOpacity(0.9),
        Colors.blue[900]!.withOpacity(0.9),
        Colors.indigo[900]!.withOpacity(0.9),
      ],
    );

    void setPrefix() {
      senderPrefix =
          messages.last.sender.id == thisUser.id ? "Du" : otherUser.vorname;
    }

    void sendMessage(value) {
      setState(() {
        messages.add(new Message(value, thisUser, otherUser));
        _textField.clear();
        setPrefix();
      });
    }

    void _goToUserProfile(User user) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => UserProfile(user: user)));
    }

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios),
              ),
              elevation: 1,
              backgroundColor: Colors.white,
              backwardsCompatibility: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.textsms_outlined),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ShaderMask(
                        blendMode: !read ? BlendMode.dst : BlendMode.dstOver,
                        shaderCallback: (bounds) => gradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                        child: ListTile(
                            leading: CircleAvatar(
                                backgroundImage: otherUser.profileImage),
                            title: Text(
                              otherUser.usersName,
                              style: TextStyle(
                                  color: !read ? Colors.black : Colors.white),
                            ),
                            subtitle: Text(
                              senderPrefix + ": " + messages.last.payload,
                              style: TextStyle(
                                  color: !read ? Colors.black : Colors.white),
                            ),
                            trailing: Text(
                              messages.last.date.format(context),
                              style: TextStyle(
                                  color: !read ? Colors.black : Colors.white),
                            ),
                            onTap: () {
                              setState(() {
                                read = !read;
                              });
                            }),
                      );
                    }),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Scaffold(
            key: _drawer,
            endDrawer: Drawer(
              child: ListView(
                children: [
                  UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: otherUser.profileImage,
                    ),
                    accountName: Text(otherUser.usersName),
                    accountEmail: Text(otherUser.mail),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title:
                        Text("Schau dir " + otherUser.vorname + "'s Profil an"),
                    onTap: () {
                      _goToUserProfile(otherUser);
                    },
                  ),
                  ListTile(),
                ],
              ),
            ),
            appBar: AppBar(
              centerTitle: true,
              elevation: 1,
              backgroundColor: Colors.white,
              title: Text(otherUser.usersName),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _drawer.currentState!.openEndDrawer();
                    },
                    child: CircleAvatar(
                      backgroundImage: otherUser.profileImage,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Material(
                    elevation: 10,
                    child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return MessageWidget(message: messages[index]);
                      },
                    ),
                  ),
                ),
                Material(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              bottom: height * 0.02),
                          child: Container(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.05),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Du musst zunächst etwas eingeben";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (value) => sendMessage(value),
                                textInputAction: TextInputAction.done,
                                controller: _textField,
                                decoration: const InputDecoration(
                                  labelText: "Deine Nachricht",
                                  border: InputBorder.none,
                                ),
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
                              sendMessage(_textField.value.text);
                            },
                            child: const Icon(Icons.send, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
