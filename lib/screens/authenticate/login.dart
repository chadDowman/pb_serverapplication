import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function toggle;

  Login({this.toggle});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0, // Takes out drop shadow
        title: Text("Sign In Coffee"),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("hello"),
            onPressed: () {
              widget.toggle();
            },
          ),
        ],
      ),
    );
  }
}
