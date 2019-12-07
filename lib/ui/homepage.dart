import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personalitydevhackathon/ui/addtasks.dart';

class HomePage extends StatefulWidget {
  String uid;
  HomePage({this.uid});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<DocumentSnapshot> userDetails;
  String greetingText;
  @override
  void initState() {
    super.initState();
    userDetails =
        Firestore.instance.collection("users").document(widget.uid).get();
    getGreeting();
  }

  void getGreeting() {
    DateTime now = DateTime.now();
    var formatter = new DateFormat('H');
    var hour = int.parse(formatter.format(now));
    if (hour < 12)
      greetingText = "Good Morning,";
    else if (hour >= 12 && hour <= 15)
      greetingText = "Good Afternoon,";
    else if (hour >= 15 && hour <= 18)
      greetingText = "Good Evening,";
    else if (hour >= 18 && hour <= 23) greetingText = "Good Night,";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: FutureBuilder(
        future: userDetails,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              print(snapshot.data.data);
              print(widget.uid);
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 15, top: 50),
                      child: ListTile(
                          title: Text(
                              greetingText + "\n" + snapshot.data.data['fname'],
                              style: TextStyle(
                                  fontFamily: "GothamR",
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          trailing: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage("images/user.png"))),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(25),
                      title: Text("Todays Tasks",
                          style: TextStyle(
                            fontFamily: "GothamR",
                            fontSize: 20,
                            color: Colors.black,
                          )),
                      trailing: FloatingActionButton(
                        mini: true,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddTasks(
                                        uid: widget.uid,
                                      )));
                        },
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.symmetric(vertical: 1.0),
                      height: 260,
                      child: ListView(
                        padding: EdgeInsets.only(left: 20, right: 40),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10, bottom: 20),
                            child: Card(
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                elevation: 10.0,
                                child: SizedBox(
                                  height: 200,
                                  width: 160,
                                  child: Text("da"),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
              break;
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
