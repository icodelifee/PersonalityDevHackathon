
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailCtlr;
  TextEditingController pswdCtlr;

  @override
  void initState() {
    super.initState();
    mailCtlr = new TextEditingController();
    pswdCtlr = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 50, top: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Welcome,",
                      style: TextStyle(
                          fontFamily: "GothamR",
                          color: Color(0xFF1B1C24),
                          fontSize: 35,
                          fontWeight: FontWeight.bold)),
                  Text(
                    "Sign in to continue",
                    style: TextStyle(
                        fontFamily: "GothamR",
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80, top: 80),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: mailCtlr,
                    decoration: InputDecoration(
                        hintText: "Email", contentPadding: EdgeInsets.all(5)),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: pswdCtlr,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 15),
                        contentPadding: EdgeInsets.all(5)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 150,top: 60),
                    child: SizedBox(
                      width: 180,
                      child: MaterialButton(
                        height: 60,
                        minWidth: 50,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              Text("Sign In",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              SizedBox(
                                width: 30,
                              ),
                              Icon(Icons.arrow_forward, color: Colors.white)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
