
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:pb_blueprotocal/shared/loading.dart';
import 'package:provider/provider.dart';

class EventCreation2 extends StatefulWidget {
  final eventName;
  final eventDescription;
  final date;
  final hour;
  final min;

  const EventCreation2(
      {Key key,
      this.eventName,
      this.eventDescription,
      this.date,
      this.hour,
      this.min})
      : super(key: key);

  @override
  _EventCreation2State createState() => _EventCreation2State(
      this.eventName, this.eventDescription, this.date, this.hour, this.min);
}

class _EventCreation2State extends State<EventCreation2> {
  String getEventName;
  String getEventDescription;
  String date;
  int hour;
  int min;

  _EventCreation2State(String getEventName, String getEventDescription,
      String date, int hour, int min) {
    this.getEventName = getEventName;
    this.getEventDescription = getEventDescription;
    this.date = date;
    this.hour = hour;
    this.min = min;
  }

  final _formKey = GlobalKey<FormState>();

  DateTime pickedDate;
  TimeOfDay time;

  @override
  void initState() {
    super.initState();
    DateTime dbDate = DateTime.parse(date);
    pickedDate = dbDate;
    TimeOfDay releaseTime = TimeOfDay(hour: hour, minute: min);
    time = releaseTime;
  }

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

    return user == null
        ? Loading()
        : StreamProvider<Event>.value(
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
                                    'Event Name: ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    initialValue: getEventName,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20),
                                      border: InputBorder.none,
                                      hintText: 'Event Name',
                                      prefixIcon: Icon(
                                        Icons.drive_file_rename_outline,
                                        color: Colors.white,
                                      ),
                                      hintStyle: kbod,
                                    ),
                                    validator: (val) => val.isEmpty
                                        ? "Event Name Missing"
                                        : null,
                                    onChanged: (val) {
                                      setState(() {
                                        getEventName = val;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Event Description',
                                    style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    constraints: BoxConstraints(maxHeight: 50),
                                    child: SingleChildScrollView(
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        initialValue: getEventDescription,
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 20),
                                          border: InputBorder.none,
                                          hintText: 'Description',
                                          prefixIcon: Icon(
                                            Icons.event,
                                            color: Colors.white,
                                          ),
                                          hintStyle: kbod,
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? "Enter A Event Description!"
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            getEventDescription = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 0),
                                  ListTile(
                                    title: Text(
                                      "Current Date ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Icon(Icons.keyboard_arrow_down),
                                    onTap: _pickDate,
                                  ),
                                  SizedBox(height: 10),
                                  ListTile(
                                    title: Text(
                                      "Current Date ${time.hour}:${time.minute}",
                                      style: TextStyle(color: Colors.white),
                                    ),
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
                              Container(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.purpleAccent))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey[800]),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      uid = user.uid;
                                      await updateEventDetails();
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 20, 10),
                                    child: Text(
                                      'Update Event',
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
                ),
              ],
            ),
          );
  }

  updateEventDetails() async {
    await Firestore.instance
        .collection('Guild_Events')
        .where(FieldPath.documentId, isEqualTo: getEventName)
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

    try{
      print("---------------------------------------UPDATE EVENT DETAILS----------------------------------------------");

      if (getEventName.isNotEmpty) {
        await DatabaseService(uid: getEventName).postEventData(uid, getEventName,getEventDescription, pickedDate.toString(), time.hour, time.minute);
        Fluttertoast.showToast(msg: "Event Successfully Updated");
      } else {
        Fluttertoast.showToast(msg: "Please Input An Event Name");
      }
    }catch (e){
      print("---------------------------------------ERROR UPDATING EVENTS---------------------------------------------");
      print(e);
      print("---------------------------------------ERROR UPDATING EVENTS---------------------------------------------");
    }


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
}
