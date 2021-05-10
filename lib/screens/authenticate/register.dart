import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggle;

  Register({this.toggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0, // Takes out drop shadow
        title: Text("Sign Up Coffee"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign Up"),
            onPressed: () {
              widget.toggle();
            },
          ),
        ],
      ),
    );
  }
}
