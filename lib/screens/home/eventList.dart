import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/screens/home/eventTile.dart';
import 'package:provider/provider.dart';

class EventList extends StatefulWidget {
  const EventList({Key key}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    final eventList = Provider.of<List<Event>>(context) ?? [];

    eventList.forEach((event) {
      print(event.eventName);
      print(event.eventDescription);
      print(event.pickedDate);
      print(event.hour);
      print(event.minute);
    });

    return ListView.builder(
      itemCount: eventList.length,
      itemBuilder: (context, index) {
        return EventTile(event: eventList[index]);
      },
    );
  }
}
