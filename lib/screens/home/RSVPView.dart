
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pb_blueprotocal/shared/loading.dart';

class RsvpViewClass extends StatefulWidget {
  final eventName;

  const RsvpViewClass({
    Key key,
    this.eventName,
  }) : super(key: key);

  @override
  _RsvpViewClassState createState() => _RsvpViewClassState(this.eventName);
}

class _RsvpViewClassState extends State<RsvpViewClass> {
  String getEventName;

  _RsvpViewClassState(String getEventName) {
    this.getEventName = getEventName;
  }

  String databaseUsername = "";
  String screenName = "RSVP Screen";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: null,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        automaticallyImplyLeading: false,
        title: Center(child: Text(screenName)),
        elevation: 0.0,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection("Guild_RSVP_Events").document("RSVPS").collection(getEventName).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            return ListView(
              children: snapshot.data.documents.map((document){
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: MediaQuery.of(context).size.width / 12,
                     child: Text(document["username"],
                         style: TextStyle(
                             fontSize: 20,
                             color: Colors.purple[300])),
                  ),
                );
              }).toList(),
            );
          }else{
            return Loading();
          }
        },
      ),
    );
  }
}
