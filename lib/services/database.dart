import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/models/user.dart';

class DatabaseService {
  final String uid;

  //Collection reference
  //Reference to a specific collection in Firestore database
  DatabaseService({this.uid}); // Constructor
  //Creates if not created and makes the database reference
  final CollectionReference userInfo =
      Firestore.instance.collection("Guild_Members");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Delete User Data Firestore
  Future _userDeleteAccount() async {
    return await userInfo.document(uid).delete();
  }

  Future deleteUserAuth(String email, String password) async {
    try {
      final FirebaseUser user = await _auth.currentUser();
      print("THE CURRENT USER!!!!!!!!!!!:");
      final uid = user.uid;
      print(uid.toString());
      AuthCredential credentials =
          EmailAuthProvider.getCredential(email: email, password: password);
      AuthResult result = await user.reauthenticateWithCredential(credentials);
      await _userDeleteAccount();
      await result.user.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

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

  final CollectionReference events =
      Firestore.instance.collection("Guild_Events");

  //----------------------------------------Event Related Things--------------------------------------

  Future updateEventData(
      String id, String eventName, String eventDescription) async {
    return await events.document(uid).setData({
      "id": id,
      "eventName": eventName,
      "eventDescription": eventDescription,
    });
  }

  Event _userEventFromSnapshot(DocumentSnapshot snapshot) {
    return Event(
      id: snapshot.data["id"],
      eventName: snapshot.data["eventName"],
      eventDescription: snapshot.data["eventDescription"],
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
          eventDescription: doc.data["eventDescription"] ?? "");
    }).toList();
  }

  //Stream For event List

  Stream<List<Event>> get eventsList {
    return events.snapshots().map(_userEventListFromSnapshot);
  }

//-------------------------------------------------------------------------------

}
