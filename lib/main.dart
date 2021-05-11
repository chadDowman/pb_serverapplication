import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/screens/authenticate/login.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
    // Creates instance of auth service and accesses the user stream on it
  }
}
