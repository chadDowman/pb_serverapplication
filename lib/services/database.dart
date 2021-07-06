import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/models/user.dart';

class DatabaseService {
  final String uid;

  //Collection reference
  //Reference to a specific collection in Firestore database
  DatabaseService({this.uid}); // Constructor
  //Creates if not created and makes the database reference

  final CollectionReference userInfo = Firestore.instance.collection("Guild_Members");

  //Sets User Data
  Future updateUserData(String username, String role, String imgUrl) async {
    return await userInfo.document(uid).setData({
      "username": username,
      "role": role,
      "imgUrl": imgUrl,
    });
  }

  //UserAccountData Stream!
  //-------------------------------------------------------------------------------
  UserAccountData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserAccountData(
      uid: uid,
      username: snapshot.data["username"],
      role: snapshot.data["role"],
      imgUrl: snapshot.data["imgUrl"],
    );
  }

  Stream<UserAccountData> get userData {
    return userInfo.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  //-------------------------------------------------------------------------------

  final CollectionReference events = Firestore.instance.collection("Guild_Events");


  //----------------------------------------Event Related Things--------------------------------------

  Future postEventData(String id, String eventName, String eventDescription,
      String pickedDate, int hour, int minute) async {
    return await events.document(uid).setData({
      "id": id,
      "eventName": eventName,
      "eventDescription": eventDescription,
      "pickedDate": pickedDate,
      "hour": hour,
      "minute": minute,
    });
  }

  Future deleteEventData() async {
    await events.document(uid).delete();
  }

  Event _userEventFromSnapshot(DocumentSnapshot snapshot) {
    return Event(
      id: snapshot.data["id"],
      eventName: snapshot.data["eventName"],
      eventDescription: snapshot.data["eventDescription"],
      pickedDate: snapshot.data["pickedDate"],
      hour: snapshot.data["hour"],
      minute: snapshot.data["minute"],
    );
  }

  Stream<Event> get eventData {
    return events.document(uid).snapshots().map(_userEventFromSnapshot);
  }

  //Event List

  List<Event> _userEventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Event(
          eventName: doc.data["eventName"] ?? "",
          pickedDate: doc.data["pickedDate"] ?? "",
          hour: doc.data["hour"] ?? 0,
          minute: doc.data["minute"] ?? 0,
          eventDescription: doc.data["eventDescription"] ?? "");
    }).toList();
  }

  //Stream For event List

  Stream<List<Event>> get eventsList {
    return events.snapshots().map(_userEventListFromSnapshot);
  }

// -------------------------------------------------------------------------------

  Future createRSVPCollection(String eventName, String username) async {
    final CollectionReference rsvpRef = Firestore.instance.collection("Guild_RSVP_Events").document("RSVPS").collection(eventName);
    return await rsvpRef.document(uid).setData({
      "id": uid,
      "username": username,
    });
  }

  Future postRSVP(String id, String username) async {
    final CollectionReference rsvpRef = Firestore.instance.collection(uid);
    return await rsvpRef.document(id).setData({
      "id": id,
      "username": username,
    });
  }

  Future deleteRSVP() async {
    await Firestore.instance.collection("Guild_RSVP_Events").document("RSVPS").collection(uid).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });


  }

}
