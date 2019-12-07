import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddTasks extends StatefulWidget {
  AddTasks({this.uid});
  final String uid;
  @override
  _AddTasksState createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  TextEditingController _tc;
  @override
  void initState() {
    super.initState();
    _tc = new TextEditingController();
  }

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  final _tcBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(10.0),
      ),
      borderSide: BorderSide(color: Colors.transparent));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Add Tasks",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: "GothamB",
              fontSize: 30),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.directions_walk,
                          color: Colors.white,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    titlePadding: EdgeInsets.all(10),
                                    contentPadding: EdgeInsets.all(10),
                                    title: Text(
                                      "Add Number Of Steps",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'GothamB'),
                                    ),
                                    children: <Widget>[
                                      TextField(
                                        controller: _tc,
                                        decoration: InputDecoration(
                                            hintText: "In Steps",
                                            border: _tcBorder,
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                            enabledBorder: _tcBorder,
                                            disabledBorder: _tcBorder),
                                      ),
                                      FlatButton(
                                        onPressed: () async {
                                          DocumentSnapshot doc = await Firestore
                                              .instance
                                              .collection('users')
                                              .document(widget.uid)
                                              .get();
                                              print(doc.data['tasks']);
                                          // if (doc.data['tasks'] == null) {
                                          //   var data = {
                                          //     "tasks": [
                                          //       {
                                          //         "taskname": "Walk",
                                          //         "task-track": _tc.text
                                          //       }
                                          //     ]
                                          //   };
                                          //   Firestore.instance
                                          //       .collection('users')
                                          //       .document(widget.uid)
                                          //       .updateData(data);
                                          // } else {
                                          //   List tasks = doc.data['tasks'].toList();
                                          //   print(tasks);
                                          //   // var data = {
                                          //   //   "taskname": "Walk",
                                          //   //   "task-track": _tc.text
                                          //   // };
                                            // Firestore.instance
                                            //     .collection('users')
                                            //     .document(widget.uid)
                                            //     .updateData(tasks);
                                          }

                                          // var data = {
                                          //   "taskname": "Walk",
                                          //   "task-track": _tc.text
                                          // };
                                          // tasksList.add(data);
                                          // Firestore.instance
                                          //     .collection('users')
                                          //     .document(widget.uid)
                                          //     .updateData(data);
                                          // var data = [
                                          //   {
                                          //     "taskname": "Walk",
                                          //     "task-track": _tc.text
                                          //   }
                                          // ];

                                          _tc.text = "";
                                        },
                                        child: Text("SUBMIT",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )
                                    ]);
                              });
                        },
                        title: Text("Walk",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "GothamB",
                                fontSize: 20)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.local_drink,
                          color: Colors.white,
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SimpleDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    titlePadding: EdgeInsets.all(10),
                                    contentPadding: EdgeInsets.all(10),
                                    title: Text(
                                      "Add Number Of Glasses Of Water",
                                      style: TextStyle(
                                          fontSize: 18, fontFamily: 'GothamB'),
                                    ),
                                    children: <Widget>[
                                      TextField(
                                        controller: _tc,
                                        decoration: InputDecoration(
                                            hintText: "Number Of Glasses",
                                            border: _tcBorder,
                                            filled: true,
                                            fillColor: Colors.grey[300],
                                            enabledBorder: _tcBorder,
                                            disabledBorder: _tcBorder),
                                      ),
                                      FlatButton(
                                        onPressed: () async {
                                          var box = await Hive.openBox('tasks');
                                          var taskBox = box.get("task");
                                          var data = {
                                            "taskname": "Water",
                                            "task-track": _tc.text
                                          };
                                          taskBox.push(data);
                                          box.put('task', taskBox);
                                          print(box.get("task"));
                                          _tc.text = "";
                                        },
                                        child: Text("SUBMIT",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      )
                                    ]);
                              });
                        },
                        title: Text("Drink Water",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "GothamB",
                                fontSize: 20)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.hotel,
                          color: Colors.white,
                        ),
                        onTap: () {},
                        title: Text("Sleep",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "GothamB",
                                fontSize: 20)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.fastfood,
                          color: Colors.white,
                        ),
                        onTap: () {},
                        title: Text("Calorie Intake",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "GothamB",
                                fontSize: 20)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Theme.of(context).primaryColor,
                      child: ListTile(
                        leading: Icon(
                          Icons.book,
                          color: Colors.white,
                        ),
                        onTap: () {},
                        title: Text("Read",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "GothamB",
                                fontSize: 20)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
