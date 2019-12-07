import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

TextEditingController fName = new TextEditingController();
TextEditingController lName = new TextEditingController();
TextEditingController age = new TextEditingController();
TextEditingController dob = new TextEditingController();
TextEditingController height = new TextEditingController();
TextEditingController weight = new TextEditingController();

class AddUserDetails extends StatelessWidget {
  AddUserDetails(this.uid);

  final String uid;
  final _tcBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        const Radius.circular(10.0),
      ),
      borderSide: BorderSide(color: Colors.transparent));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              detailsTextField("Age", age),
              detailsTextField("Date Of Birth (in DD-MM-YYYY)", dob),
              detailsTextField("Height (in cm)", height),
              detailsTextField("Weight (in kg)", weight),
              proceedButton(context)
            ],
          ),
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
              age.text.isNotEmpty &&
              dob.text.isNotEmpty &&
              weight.text.isNotEmpty &&
              height.text.isNotEmpty) {
            var doc = await Firestore.instance
                .collection('users')
                .document(uid)
                .setData({
              "fname": fName.text,
              "lname": lName.text,
              "age": age.text,
              "dob": dob.text,
              "weight": weight.text,
              "height": height.text,
            });
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
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
