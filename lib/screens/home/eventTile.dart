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
        child: ExpansionTile(
          leading: CircleAvatar(
            //The left image thing
            backgroundImage: AssetImage("pics/PixelatedBrosPic.png"),
            radius: 25,
          ),
          title: Text(event.eventName),
          children: [Text(event.eventDescription)],
        ),
      ),
    );
  }
}
