import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/shared/custom.dart' as custom;
class EventTile extends StatelessWidget {
  final Event event;

  EventTile({this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.grey[900],
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ExpansionTile(
          backgroundColor: Colors.grey[900],
          leading: CircleAvatar(
            //The left image thing
            backgroundImage: AssetImage("pics/PixelatedBrosPic.png"),
            radius: 25,
          ),
          title: Text(event.eventName,
          style: TextStyle(color: Colors.deepPurple)),
          subtitle: Text(event.eventDate, style: TextStyle(color: Colors.deepPurple)),
          children: [Text(event.eventDescription,
            style: TextStyle(color: Colors.deepPurple))],
        ),
      ),
    );
  }
}
