import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xFFEC2637);
  final Color primaryBgColor = Color(0xFFE5E4E5);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personality Tracker',
      theme: ThemeData(
          fontFamily: "GothamR",
          primaryColor: primaryColor,
          backgroundColor: primaryBgColor),
      home: LoginIntro(),
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
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

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
