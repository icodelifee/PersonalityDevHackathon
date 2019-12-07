import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personalitydevhackathon/services/firebase/authentication.dart';
import 'package:personalitydevhackathon/ui/homepage.dart';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  LoginPage(this.auth);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailCtlr;
  TextEditingController pswdCtlr;
  bool _validate = false;
  bool _validateemail = false;
  String _submitText = "Sign In";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    mailCtlr = new TextEditingController();
    pswdCtlr = new TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => showInSnackBar("Long Press Sign In To Sign Up"));
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: Duration(seconds: 3),
      content: new Text(
        value,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      backgroundColor: Colors.white,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    emailTextFeild(),
                    SizedBox(
                      height: 40,
                    ),
                    passwdTextField(),
                    signInButton(context)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding signInButton(BuildContext context) {
    String userId;
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: SizedBox(
        width: 180,
        child: MaterialButton(
          height: 60,
          minWidth: 50,
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Text(_submitText,
                    style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(
                  width: 30,
                ),
                Icon(Icons.arrow_forward, color: Colors.white)
              ],
            ),
          ),
          onLongPress: () {
            setState(() {
              _submitText = _submitText == "Sign In" ? "Sign Up" : "Sign In";
            });
          },
          onPressed: () async {
            if (_validate == false && _validateemail == false) {
              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(mailCtlr.text);
              if (emailValid != true) {
                _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  duration: Duration(seconds: 3),
                  content: new Text(
                    'Invalid Email',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  backgroundColor: Colors.white,
                ));
              } else {
                if (_submitText == "Sign In") {
                  userId =
                      await widget.auth.signIn(mailCtlr.text, pswdCtlr.text);
                  if (userId == "No User Found")
                    showInSnackBar("No User Found!");
                  else {
                    var box = await Hive.openBox('userData');
                    box.put("user", {"userid": userId});
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                } else {
                  userId =
                      await widget.auth.signUp(mailCtlr.text, pswdCtlr.text);
                  var box = await Hive.openBox('userData');
                  box.put("user", {"userid": userId});
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddUserDetails(userId)));
                }
              }
            }
          },
        ),
      ),
    );
  }

  TextField passwdTextField() {
    return TextField(
      controller: pswdCtlr,
      obscureText: true,
      onChanged: (val) {
        setState(() {
          val.isEmpty ? _validate = true : _validate = false;
        });
      },
      decoration: InputDecoration(
          hintText: "Password",
          errorText: _validate ? 'Password Can\'t Be Empty' : null,
          hintStyle: TextStyle(fontSize: 15),
          contentPadding: EdgeInsets.all(5)),
    );
  }

  TextField emailTextFeild() {
    return TextField(
      controller: mailCtlr,
      onChanged: (val) {
        setState(() {
          val.isEmpty ? _validateemail = true : _validateemail = false;
        });
      },
      decoration: InputDecoration(
          errorText: _validateemail ? 'Email Can\'t Be Empty' : null,
          hintText: "Email",
          contentPadding: EdgeInsets.all(5)),
    );
  }
}
