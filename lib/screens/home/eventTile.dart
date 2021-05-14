import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/models/event.dart';

class EventTile extends StatelessWidget {
  final Event event;

  EventTile({this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            //The left image thing
            radius: 25,
            backgroundColor: Colors.brown[200],
          ),
          title: Text(event.eventName),
          subtitle: Text(event.eventDescription),
        ),
      ),
    );
  }
}
