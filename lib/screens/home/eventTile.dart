import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/screens/home/eventUpdates.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:pb_blueprotocal/shared/custom.dart' as custom;
import 'package:pb_blueprotocal/shared/loading.dart';
import 'package:provider/provider.dart';

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

  DateTime currentDate;
  bool removeEvent = false;
  DateTime dbDate;
  DatabaseService dbService = new DatabaseService();
  String userUID = "";
  String username = "";


  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    dbDate = DateTime.parse(widget.event.pickedDate);

    // if(dbDate.isBefore(currentDate)){
    //   print('----------------------------------------------------------------');
    //   Duration showEvent = dbDate.difference(currentDate);
    //   print(currentDate);
    //   print('----------------------------------------------------------------');
    //   print(widget.event.pickedDate);
    //   print('----------------------------------------------------------------');
    //   print(showEvent.inDays);
    //   int difference = showEvent.inDays;
    //   if(difference < -5){
    //     print('LIFE!!!!!!!!!!!');
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null
        ? Loading()
        : StreamBuilder<UserAccountData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserAccountData userAccountData = snapshot.data;
                userUID = user.uid;
                username = userAccountData.username;
                if (userAccountData.role == "admin") {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Card(
                      color: Colors.grey[900],
                      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: dbDate.isBefore(
                                currentDate.subtract(Duration(days: 6)))
                            ? null
                            : ExpansionTile(
                                backgroundColor: Colors.grey[900],
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  //The left image thing
                                  backgroundImage: AssetImage("pics/PB.png"),
                                  radius: 25,
                                ),
                                title: Text(widget.event.eventName,
                                    style:
                                        TextStyle(color: Colors.purple[300])),
                                subtitle: Text(
                                    widget.event.pickedDate.substring(0, 11) +
                                        "  at  " +
                                        widget.event.hour.toString() +
                                        " : " +
                                        widget.event.minute.toString() +
                                        " GMT+2",
                                    style:
                                        TextStyle(color: Colors.purple[300])),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Text(widget.event.eventDescription,
                                        style: TextStyle(
                                            color: Colors.purple[300])),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Colors
                                                            .purpleAccent))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey[800]),
                                          ),
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EventCreation2(
                                                          eventName: widget
                                                              .event.eventName,
                                                          eventDescription: widget
                                                              .event
                                                              .eventDescription,
                                                          date: widget
                                                              .event.pickedDate
                                                              .toString(),
                                                          hour:
                                                              widget.event.hour,
                                                          min: widget
                                                              .event.minute,
                                                        )));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              'Update Event',
                                              style: butt,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 10,
                                        ),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                    side: BorderSide(
                                                        color: Colors
                                                            .purpleAccent))),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.grey[800]),
                                          ),
                                          onPressed: () async {
                                            await deleteEvent();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              'Delete Event',
                                              style: butt,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Card(
                      color: Colors.grey[900],
                      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: dbDate.isBefore(
                                currentDate.subtract(Duration(days: 6)))
                            ? null
                            : ExpansionTile(
                                backgroundColor: Colors.grey[900],
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  //The left image thing
                                  backgroundImage: AssetImage("pics/PB.png"),
                                  radius: 25,
                                ),
                                title: Text(widget.event.eventName,
                                    style:
                                        TextStyle(color: Colors.purple[300])),
                                subtitle: Text(
                                    widget.event.pickedDate.substring(0, 11) +
                                        "  at  " +
                                        widget.event.hour.toString() +
                                        " : " +
                                        widget.event.minute.toString() +
                                        " GMT+2",
                                    style:
                                        TextStyle(color: Colors.purple[300])),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Text(widget.event.eventDescription,
                                        style: TextStyle(
                                            color: Colors.purple[300])),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                      ),
                    ),
                  );
                }
              } else {
                return Loading();
              }
            },
          );
  }

  // rsvpEvent() async {
  //   DatabaseService(uid: widget.event.eventName).postRSVP(userUID, username);
  // }
  //
  // rsvpDelete() async{
  //   await DatabaseService(uid: widget.event.eventName).deleteRSVP();
  // }

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
