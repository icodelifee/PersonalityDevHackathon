import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personalitydevhackathon/services/firebase/authentication.dart';
import 'package:personalitydevhackathon/ui/homepage.dart';
import 'package:personalitydevhackathon/ui/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

var user;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  var box = await Hive.openBox('userData');
  user = box.get("user")["userid"];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("tasks", "[]");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xFFEC2637);
  final Color primaryBgColor = Color(0xFFE5E4E5);
  final Color cardColor = Color(0xFF4D53E0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personality Tracker',
      theme: ThemeData(
          fontFamily: "GothamR",
          primaryColor: primaryColor,
          cardColor: cardColor,
          backgroundColor: primaryBgColor),
      home: user == null
          ? LoginIntro()
          : HomePage(
              uid: user,
            ),
    );
  }
}

class LoginIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 30, right: 30, bottom: 30),
              child: SvgPicture.asset(
                'images/login.svg',
                alignment: Alignment.topCenter,
                height: 200,
                width: 200,
              ),
            ),
            Text(
              "Ready to\nMould yourself?",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: "GothamR",
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                "Personality development is the relatively enduring pattern of the thoughts, feelings, and behaviors that distinguish individuals from one another.",
                style: TextStyle(color: Colors.white70, fontFamily: "GothamL")),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "Get Started",
                  style: TextStyle(
                      fontFamily: "GothamR",
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                trailing: MaterialButton(
                  elevation: 10,
                  height: 55,
                  minWidth: 30,
                  color: Colors.white,
                  child: Icon(Icons.arrow_forward),
                  onPressed: () async {
                    Map<PermissionGroup, PermissionStatus> permissions =
                        await PermissionHandler()
                            .requestPermissions([PermissionGroup.storage]);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                LoginPage(Auth())));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
