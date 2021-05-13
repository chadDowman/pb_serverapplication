import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/screens/authenticate/login.dart';
import 'package:pb_blueprotocal/screens/home/profile.dart';
import 'package:pb_blueprotocal/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService(); // Instance of auth service class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("HOME SCREEN"),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Logout"),
            onPressed: () async {
              await _auth.logOut(); // Calls sign out function
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          ),
        ],
      ),
      body: Text(""),
    );
  }
}
