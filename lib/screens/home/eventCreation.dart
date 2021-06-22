import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/screens/home/eventTile.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:pb_blueprotocal/shared/loading.dart';
import 'package:provider/provider.dart';

class EventCreation extends StatefulWidget {
  @override
  _EventCreationState createState() => _EventCreationState();
}

class _EventCreationState extends State<EventCreation> {
  final _formKey = GlobalKey<FormState>();
  String eventID = "";
  String eventName = "";
  String eventDescription = "";
  String uid = "";
  String month = "";
  String day = "";
  String time = "";
  String dateAndTimeString = "";
  String databaseName = "";
  String databaseDate = "";
  String databaseDescription = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<Event>.value(
      value: DatabaseService().eventData,
      initialData: null,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.grey[900],
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Divider(
                              height: 60,
                              color: Colors.grey[800],
                            ),
                            Text(
                              'Enter the name of the event',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                border: InputBorder.none,
                                hintText: 'Event Name',
                                prefixIcon: Icon(
                                  Icons.drive_file_rename_outline,
                                  color: Colors.white,
                                ),
                                hintStyle: kbod,
                              ),
                              validator: (val) =>
                                  val.isEmpty ? "Enter A Event Name!" : null,
                              onChanged: (val) {
                                setState(() {
                                  eventName = val;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Describe the Event that is taking place',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                border: InputBorder.none,
                                hintText: 'Description',
                                prefixIcon: Icon(
                                  Icons.event,
                                  color: Colors.white,
                                ),
                                hintStyle: kbod,
                              ),
                              validator: (val) => val.length < 10
                                  ? "Enter A Event Description!"
                                  : null,
                              onChanged: (val) {
                                setState(() {
                                  eventDescription = val;
                                });
                              },
                            ),
                            SizedBox(height: 0),
                            TextFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  border: InputBorder.none,
                                  hintText: 'Month',
                                  prefixIcon: Icon(
                                    Icons.calendar_view_day,
                                    color: Colors.white,
                                  ),
                                  hintStyle: butt,
                                ),
                                validator: (val) => val.isEmpty
                                    ? "Enter a Month for the event"
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    month = val;
                                  });
                                }),
                            SizedBox(height: 0),
                            TextFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  border: InputBorder.none,
                                  hintText: 'Day',
                                  prefixIcon: Icon(
                                    Icons.calendar_view_day,
                                    color: Colors.white,
                                  ),
                                  hintStyle: butt,
                                ),
                                validator: (val) => val.isEmpty
                                    ? "Enter a Day for the event"
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    day = val;
                                  });
                                }),
                            SizedBox(height: 0),
                            TextFormField(
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  border: InputBorder.none,
                                  hintText: 'Time',
                                  prefixIcon: Icon(
                                    Icons.alarm_add_sharp,
                                    color: Colors.white,
                                  ),
                                  hintStyle: butt,
                                ),
                                validator: (val) => val.isEmpty
                                    ? "Enter a Timer for the event"
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    time = val;
                                  });
                                }),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      eventID = eventName;
                                      uid = user.uid;
                                      await postEventDetails();
                                    }
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 20, 10),
                                    child: Text(
                                      'Post Event',
                                      style: butt2,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                                  ),
                                  onPressed: () async {
                                    uid = user.uid;
                                    updateEventDetails();
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 0, 10),
                                    child: Text(
                                      'Update Event',
                                      style: butt2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                              ),
                              onPressed: () async {
                                uid = user.uid;
                                await deleteEvent();
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Text(
                                  'Delete Event',
                                  style: butt2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  postEventDetails() async {
    try {
      dateAndTimeString = day + " " + month + " at " + time + " GMT+2";
      print(
          "---------------------------------------Attempting to add/change Event Details----------------------------------------------");

      await DatabaseService(uid: eventName)
          .postEventData(uid, eventName, eventDescription, dateAndTimeString);

      Fluttertoast.showToast(msg: "User Event Successfully Updated");
      print(
          "---------------------------------------Event Details Updated/added Successfully----------------------------------------------");
    } catch (e) {
      print(
          "---------------------------------------An Error Has Occurred Well Adding/Changing Event Details----------------------------------------------");
      print(e.toString());
      print(
          "---------------------------------------End of Error Report For Event Related Things----------------------------------------------");
    }
  }

  deleteEvent() async {
    await Firestore.instance
        .collection('Guild_Events')
        .where(FieldPath.documentId, isEqualTo: eventName)
        .getDocuments()
        .then((event) {
      if (event.documents.isNotEmpty) {
        Map<String, dynamic> documentData =
            event.documents.single.data; //if it is a single document
        print(documentData["eventDescription"]);
        print(documentData["eventName"]);
        print(documentData["eventDate"]);
        databaseName = documentData["eventName"];
        databaseDate = documentData["eventDate"];
        databaseDescription = documentData["eventDescription"];
      }
    }).catchError((e) => print("error fetching data: $e"));
    await DatabaseService(uid: eventName).deleteEventData();
  }

  updateEventDetails() async {
    await Firestore.instance
        .collection('Guild_Events')
        .where(FieldPath.documentId, isEqualTo: eventName)
        .getDocuments()
        .then((event) {
      if (event.documents.isNotEmpty) {
        Map<String, dynamic> documentData =
            event.documents.single.data; //if it is a single document
        print(documentData["eventDescription"]);
        print(documentData["eventName"]);
        print(documentData["eventDate"]);
        databaseName = documentData["eventName"];
        databaseDate = documentData["eventDate"];
        databaseDescription = documentData["eventDescription"];
      }
    }).catchError((e) => print("error fetching data: $e"));

    print(
        "---------------------------------------UPDATE EVENT DETAILS----------------------------------------------");
    if (eventDescription.isNotEmpty &&
        day.isNotEmpty &&
        month.isNotEmpty &&
        time.isNotEmpty) {
      dateAndTimeString = day + " " + month + " at " + time + " GMT+2";
      await DatabaseService(uid: eventName)
          .postEventData(uid, eventName, eventDescription, dateAndTimeString);
      Fluttertoast.showToast(msg: "Record Updated");
    } else if (eventDescription.isNotEmpty &&
        day.isEmpty &&
        month.isEmpty &&
        time.isEmpty) {
      await DatabaseService(uid: eventName)
          .postEventData(uid, eventName, eventDescription, databaseDate);
      Fluttertoast.showToast(msg: "Description Updated");
    } else if (day.isNotEmpty &&
        month.isNotEmpty &&
        time.isNotEmpty &&
        eventDescription.isEmpty) {
      dateAndTimeString = day + " " + month + " at " + time + " GMT+2";
      await DatabaseService(uid: eventName).postEventData(
          uid, eventName, databaseDescription, dateAndTimeString);
      Fluttertoast.showToast(msg: "Date Updated");
    } else {
      Fluttertoast.showToast(msg: "Missing Fields");
    }
  }
}
