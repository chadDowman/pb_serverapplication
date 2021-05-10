import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/screens/authenticate/login.dart';
import 'package:pb_blueprotocal/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signIn = true;

  void toggle() {
    setState(() {
      signIn = !signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (signIn) {
      return Login(toggle: toggle);
    }else{
      return Register(toggle: toggle);
    }
  }
}
