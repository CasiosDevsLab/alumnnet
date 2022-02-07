import 'package:alumnnet/Class/User.dart';
import 'package:alumnnet/Screens/Chat.dart';
import 'package:alumnnet/Screens/Userdata/UserProfile.dart';
import 'package:alumnnet/Screens/Userdata/UserSettings.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Widget build(BuildContext context) {
    final Gradient gradient = LinearGradient(
      colors: <Color>[
        Colors.blue,
        Colors.blue[700] as Color,
        Colors.blue[900] as Color,
        Colors.indigo[900] as Color,
      ],
    );

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final User user = widget.user;
    User otherUser = User.withData(
        id: 1,
        vorname: "Gerrit",
        nachname: "Remané",
        mail: "gerrit@mail.de",
        position: "Dozent",
        firma: "FH Wedel",
        alter: 35);

    otherUser.profileImage = Image.asset("pb.jpg").image;
    otherUser.setInterests(["Roland Berger", "Beratung", "Bier"]);
    otherUser.description =
        "Moin, ich bin Gerrit! \n Ihr kennt mich aus dem Jahrgang '86 - wer mich nicht kennt war im falschen Jahrgang! Kleiner Spaß. Wer einen Gastvortrag in meinem Unterricht halten möchte schreibt mich an";

    void _goToChat(User thisUser, User otherUser) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Chat(
                thisUser: thisUser,
                otherUser: otherUser,
              )));
    }

    void _goToUserprofile(User thisUser) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => UserProfile(
                user: thisUser,
              )));
    }

    void _goToUserSettings(User thisUser) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => UserSettings(
                user: thisUser,
              )));
    }

    return Scaffold(
      key: _key,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo[900]!.withOpacity(0.8),
        centerTitle: true,
        toolbarHeight: height * 0.1,
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: 10),
          width: width * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: "Suche nach anderen Usern",
                border: InputBorder.none,
              )),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _key.currentState!.openEndDrawer(),
              child: CircleAvatar(
                backgroundImage: user.profileImage,
              ),
            ),
          )
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => _goToUserprofile(user),
              child: UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: user.profileImage,
                ),
                accountName: Text(user.usersName),
                accountEmail: Text(user.mail),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: Text("Deine Chats"),
              leading: Icon(Icons.chat),
              onTap: () => _goToChat(user, otherUser),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Konto bearbeiten"),
              onTap: () => _goToUserSettings(user),
            ),
          ],
        ),
      ),
      body: Container(),
    );
  }
}
