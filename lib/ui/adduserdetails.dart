import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:groovin_widgets/outline_dropdown_button.dart';
import 'package:intl/intl.dart';
import 'package:personalitydevhackathon/ui/homepage.dart';

class AddUserDetails extends StatefulWidget {
  AddUserDetails(this.uid);

  final String uid;

  @override
  _AddUserDetailsState createState() => _AddUserDetailsState();
}

class _AddUserDetailsState extends State<AddUserDetails> {
  TextEditingController fName;
  TextEditingController lName;
  String dob;
  String age;
  String gender = "m";
  TextEditingController height;
  TextEditingController weight;

  final _tcBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(10.0),
      ),
      borderSide: BorderSide(color: Colors.transparent));
  @override
  void initState() {
    super.initState();
    fName = new TextEditingController();
    lName = new TextEditingController();
    weight = new TextEditingController();
    height = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 10),
                child: Text("Hello, We Want To Know More About You.",
                    style: TextStyle(
                      fontFamily: "GothamB",
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              detailsTextField("First Name", fName),
              detailsTextField("Last Name", lName),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.grey[400],
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1950, 3, 5),
                        maxTime: DateTime.now(), onChanged: (date) {
                      // print('change $date');
                    }, onConfirm: (date) {
                      var formatter = new DateFormat('yyyy-MM-dd');
                      dob = formatter.format(date);
                      var now = DateTime.now();
                      setState(() {
                        age = (now.year - date.year).toString();
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: ListTile(
                      title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(age ?? "Date Of Birth"),
                    ],
                  )),
                ),
              ),
              detailsTextField("Height (in cm)", height),
              detailsTextField("Weight (in kg)", weight),
              genderDropDown(),
              proceedButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Padding genderDropDown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        child: OutlineDropdownButton(
          inputDecoration: InputDecoration(
              border: _tcBorder,
              filled: true,
              fillColor: Colors.grey[400],
              enabledBorder: _tcBorder,
              disabledBorder: _tcBorder),
          items: [
            DropdownMenuItem(
              child: Text("Male"),
              value: "m",
            ),
            DropdownMenuItem(
              child: Text("Female"),
              value: "f",
            ),
            DropdownMenuItem(
              child: Text("Other"),
              value: "o",
            ),
          ],
          isExpanded: true,
          hint: Text("Select Gender"),
          value: gender,
          onChanged: (value) {
            setState(() {
              gender = value;
            });
          },
        ),
      ),
    );
  }

  Container proceedButton(BuildContext context) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(10),
      child: MaterialButton(
        height: 60,
        minWidth: 90,
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Proceed",
                style: TextStyle(fontSize: 15, color: Colors.white)),
            Icon(Icons.arrow_forward, color: Colors.white)
          ],
        ),
        onPressed: () async {
          if (lName.text.isNotEmpty &&
              fName.text.isNotEmpty &&
              dob.isNotEmpty &&
              age.isNotEmpty &&
              gender.isNotEmpty &&
              weight.text.isNotEmpty &&
              height.text.isNotEmpty) {
            await Firestore.instance
                .collection('users')
                .document(widget.uid)
                .setData({
              "fname": fName.text,
              "lname": lName.text,
              "dob": dob,
              "age": age,
              "gender": gender,
              "weight": weight.text,
              "height": height.text,
              "tasks": []
            }, merge: true);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(
                          uid: widget.uid,
                        )));
          }
        },
      ),
    );
  }

  Padding detailsTextField(String hintText, TextEditingController tc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: tc,
        decoration: InputDecoration(
            hintText: hintText,
            border: _tcBorder,
            filled: true,
            fillColor: Colors.grey[400],
            enabledBorder: _tcBorder,
            disabledBorder: _tcBorder),
      ),
    );
  }
}
