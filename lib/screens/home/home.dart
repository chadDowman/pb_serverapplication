import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/screens/home/eventList.dart';
import 'package:pb_blueprotocal/screens/home/profile.dart';
import 'package:pb_blueprotocal/services/auth.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Event>>.value(
      value: DatabaseService().eventsList,
      child: Scaffold(
        body: EventList(),
      ),
    );
  }
}
