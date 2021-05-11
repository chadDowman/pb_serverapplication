import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/screens/wrapper.dart';
import 'package:pb_blueprotocal/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      // Creates instance of auth service and accesses the user stream on it
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}