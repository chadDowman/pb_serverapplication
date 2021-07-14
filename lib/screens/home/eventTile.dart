import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/screens/home/RSVPView.dart';
import 'package:pb_blueprotocal/screens/home/eventUpdates.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
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

  String databaseUsername = "";
  String databaseID = "";

  DateTime currentDate;
  bool removeEvent = false;
  DateTime dbDate;
  DatabaseService dbService = new DatabaseService();
  String userUID = "";
  String username = "";
  bool rsvp = false;

  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    dbDate = DateTime.parse(widget.event.pickedDate);

    var androidInitilize = new AndroidInitializationSettings('pb');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
        new InitializationSettings(androidInitilize, iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
    _showNotification();

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

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  Future _showNotification() async {
    await fltrNotification.cancelAll();
    try {
      var androidDetails = new AndroidNotificationDetails(
          "Channel ID", "Desi programmer", "This is my channel",
          importance: Importance.Max);
      var iSODetails = new IOSNotificationDetails();
      var generalNotificationDetails =
          new NotificationDetails(androidDetails, iSODetails);

      print('NOTIFICATION STARTING TO SET');
      print(dbDate);
      if(dbDate.isAfter(currentDate)){
        var scheduledTime = dbDate.subtract(Duration(days: 5));
        print('---------------------------------Scheduled Time---------------------------------------');
        print(scheduledTime);
        print('------------------------------------------------------------------------');
        fltrNotification.schedule(1, "An Event Will Start In 5 Days",
            widget.event.eventName, scheduledTime, generalNotificationDetails);
        print('NOTIFICATION IS SET');

      }else if (dbDate.difference(currentDate).inDays == 0){
        print(dbDate.add(Duration(hours: widget.event.hour, minutes: widget.event.minute)));
        var scheduledTime2 = dbDate.add(Duration(hours: widget.event.hour, minutes: widget.event.minute));
        fltrNotification.schedule(1, "The Event Has Started",
            widget.event.eventName, scheduledTime2, generalNotificationDetails);
        print('IT IS THE SAME AS THE CURRENT DATE');
      }else{
        print('DATE ALREADY PASSED');
      }

    } catch (e) {
      print(
          '-----------------NOTIFICATION ERROR OCCURRED---------------------------');
      print(e);
      print(
          '-----------------NOTIFICATION ERROR FINISHED---------------------------');
    }
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
                                            if (rsvp) {
                                              await rsvpDelete();
                                            } else {
                                              await rsvpEvent();
                                            }
                                            setState(() {
                                              rsvp = !rsvp;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              'RSVP For Event',
                                              style: butt,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
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
                                                        RsvpViewClass(
                                                          eventName: widget
                                                              .event.eventName,
                                                        )));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              'View RSVPS',
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
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
                                            if (rsvp) {
                                              await rsvpDelete();
                                            } else {
                                              await rsvpEvent();
                                            }
                                            setState(() {
                                              rsvp = !rsvp;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              'RSVP For Event',
                                              style: butt,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
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
                                                        RsvpViewClass(
                                                          eventName: widget
                                                              .event.eventName,
                                                        )));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
                                            child: Text(
                                              'View RSVPS',
                                              style: butt,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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

  rsvpEvent() async {
    await DatabaseService(uid: userUID)
        .createRSVPCollection(widget.event.eventName, username);
  }

  // Firestore.instance.collection("Guild_RSVP_Events").document("RSVPS").collection(getEventName)
  rsvpDelete() async {
    await DatabaseService(uid: userUID).deleteUserRSVP(widget.event.eventName);
  }

  //

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
    await DatabaseService(uid: widget.event.eventName).deleteRSVP();
    Fluttertoast.showToast(msg: "Event Deleted if Exists");
  }
}
