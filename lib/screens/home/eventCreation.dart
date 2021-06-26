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
  const EventCreation({Key key}) : super(key: key);

  @override
  _EventCreationState createState() => _EventCreationState();
}

class _EventCreationState extends State<EventCreation> {
  final _formKey = GlobalKey<FormState>();

  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  String eventID = "";
  String eventName = "";
  String eventDescription = "";
  String uid = "";
  String dateAndTimeString = "";
  String databaseName = "";
  String databaseDate;
  int databaseHour = 0;
  int databaseMinute = 0;
  String databaseDescription = "";
  int timeHour;
  int timeMinute;

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
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
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
                            ListTile(
                              title: Text(
                                  "Current Date ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                              trailing: Icon(Icons.keyboard_arrow_down),
                              onTap: _pickDate,
                            ),
                            SizedBox(height: 10),
                            ListTile(
                              title: Text(
                                  "Current Date ${time.hour}:${time.minute}"),
                              trailing: Icon(Icons.keyboard_arrow_down),
                              onTap: _pickTime,
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Container(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[800]),
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
                                      style: butt,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Container(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[800]),
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
                                      style: butt,
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey[800]),
                            ),
                            onPressed: () async {
                              uid = user.uid;
                              await deleteEvent();
                            },
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                              child: Text(
                                'Delete Event',
                                style: butt,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );

    if (date != null) {
      setState(() {
        print(date);
        pickedDate = date;
      });
    }
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (t != null) {
      setState(() {
        print(t);
        time = t;
      });
    }
  }

  postEventDetails() async {
    try {
      print(
          "---------------------------------------Attempting to add/change Event Details----------------------------------------------");
      print(pickedDate);

      print(time);
      print(time.hour);
      print(time.minute);
      await DatabaseService(uid: eventName).postEventData(uid, eventName, eventDescription, pickedDate.toString(), time.hour, time.minute);


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
    await DatabaseService(uid: eventName).deleteEventData();
    Fluttertoast.showToast(msg: "Event Deleted if Exists");
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

    print(
        "---------------------------------------UPDATE EVENT DETAILS----------------------------------------------");
    if (eventName.isNotEmpty) {
      if (eventName != databaseName) {
        Fluttertoast.showToast(msg: "Event Does Not Exist");
      } else {
        if (eventDescription.isNotEmpty) {
          await DatabaseService(uid: eventName).postEventData(uid, eventName, eventDescription, databaseDate, databaseHour, databaseMinute);
          Fluttertoast.showToast(msg: "Record Description Updated");
        } else {
          await DatabaseService(uid: eventName).postEventData(uid, eventName, databaseDescription, pickedDate.toString(), time.hour, time.minute);

          Fluttertoast.showToast(msg: "Record Description Updated");
        }
      }
    } else {
      Fluttertoast.showToast(msg: "Please Input Event Name");
    }
  }
}



