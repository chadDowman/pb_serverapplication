import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/screens/home/eventUpdates.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:pb_blueprotocal/shared/custom.dart' as custom;
class EventTile extends StatefulWidget {
  final Event event;

  EventTile({this.event});

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {

  String databaseName = "";
  String databaseDate;
  int databaseHour = 0;
  int databaseMinute = 0;
  String databaseDescription = "";

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
            backgroundImage: AssetImage("pics/PB.png"),
            radius: 25,
          ),
          title: Text(widget.event.eventName,
          style: TextStyle(color: Colors.purple[300])),
          subtitle: Text(widget.event.pickedDate.substring(0, 11) + "  at  " + widget.event.hour.toString() + " : " + widget.event.minute.toString() + " GMT+2", style: TextStyle(color: Colors.purple[300])),
          children: [
            Text(widget.event.eventDescription,
            style: TextStyle(color: Colors.purple[300])),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(
                        Colors.grey[800]),
                  ),
                  onPressed: () async {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => EventCreation2(eventName: widget.event.eventName, eventDescription: widget.event.eventDescription, date: widget.event.pickedDate.toString(), hour: widget.event.hour, min: widget.event.minute,)));
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(
                        vertical: 16.0),
                    child: Text(
                      'Update Event',
                      style: butt,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(
                        Colors.grey[800]),
                  ),
                  onPressed: () async {
                    await deleteEvent();
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(
                        vertical: 16.0),
                    child: Text(
                      'Delete Event',
                      style: butt,
                    ),
                  ),
                ),
              ],

            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  deleteEvent() async {
    await Firestore.instance
        .collection('Guild_Events')
        .where(FieldPath.documentId, isEqualTo: widget.event.eventName)
        .getDocuments()
        .then((event) {
      if (event.documents.isNotEmpty) {
        Map<String, dynamic> documentData =
            event.documents.single.data; //if it is a single document
        print(documentData["eventDescription"]);
        print(documentData["eventName"]);
        print(documentData["pickedDate"]);
        print(documentData["hour"]);
        print(documentData["minute"]);
        databaseName = documentData["eventName"];
        databaseDate = documentData["pickedDate"];
        databaseHour = documentData["hour"];
        databaseMinute = documentData["minute"];
        databaseDescription = documentData["eventDescription"];
      }
    }).catchError((e) => print("error fetching data: $e"));
    await DatabaseService(uid: widget.event.eventName).deleteEventData();
    Fluttertoast.showToast(msg: "Event Deleted if Exists");
  }
}
