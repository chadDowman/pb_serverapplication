import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:pb_blueprotocal/services/eventDatabase.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:pb_blueprotocal/shared/loading.dart';
import 'package:provider/provider.dart';

class EventCreation extends StatefulWidget {
  @override
  _EventCreationState createState() => _EventCreationState();
}

class _EventCreationState extends State<EventCreation> {

  final _formKey = GlobalKey<FormState>();
  String eventID;
  String eventName;
  String eventDescription;
  String uid;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<Event>.value(
      value: DatabaseService().eventData,
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
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
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
                              validator: (val) => val.isEmpty ? "Enter A Event Name!" : null,
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
                              validator: (val) => val.length < 10 ? "Enter A Event Description!" : null,
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
                                const EdgeInsets.symmetric(
                                    vertical: 20),
                                border: InputBorder.none,
                                hintText: 'Month',
                                prefixIcon: Icon(
                                  Icons.calendar_view_day,
                                  color: Colors.white,
                                ),
                                hintStyle: butt,
                              ),
                            ),
                            SizedBox(height: 0),
                            TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(
                                    vertical: 20),
                                border: InputBorder.none,
                                hintText: 'Day',
                                prefixIcon: Icon(
                                  Icons.calendar_view_day,
                                  color: Colors.white,
                                ),
                                hintStyle: butt,
                              ),
                            ),
                            SizedBox(height: 0),
                            TextFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(
                                    vertical: 20),
                                border: InputBorder.none,
                                hintText: 'Time',
                                prefixIcon: Icon(
                                  Icons.alarm_add_sharp,
                                  color: Colors.white,
                                ),
                                hintStyle: butt,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () async{
                                    if (_formKey.currentState.validate()) {
                                      eventID = eventName;
                                      uid = user.uid;
                                      await changeEventDetails();
                                    }
                                  },
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Text(
                                      'Post Event',
                                      style: kbod,
                                    ),
                                  ),
                                ),
                              ],
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

  changeEventDetails() async {
    try{
      print("---------------------------------------Attempting to add/change Event Details----------------------------------------------");
      await DatabaseService(uid: eventName).updateEventData(uid, eventName, eventDescription);
      Fluttertoast.showToast(msg: "User Event Successfully Updated");
      print("---------------------------------------Event Details Updated/added Successfully----------------------------------------------");
    }catch(e){
      print("---------------------------------------An Error Has Occurred Well Adding/Changing Event Details----------------------------------------------");
      print(e.toString());
      print("---------------------------------------End of Error Report For Event Related Things----------------------------------------------");
    }

  }
}
