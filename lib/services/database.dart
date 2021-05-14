import 'package:cloud_firestore/cloud_firestore.dart';
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
  UserAccountData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserAccountData(
      uid: uid,
      username: snapshot.data["username"],
      role: snapshot.data["role"],
      imgUrl: snapshot.data["imgUrl"],
    );

  }
  Stream<UserAccountData> get userData{
    return userInfo.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  //-------------------------------------------------------------------------------

  final CollectionReference events = Firestore.instance.collection("Guild_Events");

  //----------------------------------------Event Related Things--------------------------------------

  Future updateEventData(String id, String eventName, String eventDescription) async{
    return await events.document(uid).setData({
      "id": id,
      "eventName": eventName,
      "eventDescription": eventDescription,
    });
  }

  Event _userEventFromSnapshot(DocumentSnapshot snapshot){
    return Event(
      id: snapshot.data["id"],
      eventName: snapshot.data["eventName"],
      eventDescription: snapshot.data["eventDescription"],
    );
  }

  Stream<Event> get eventData{
    return events.document(uid).snapshots().map(_userEventFromSnapshot);
  }

  //Event List

  List<Event> _userEventListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Event(
        eventName: doc.data["eventName"] ?? "",
        eventDescription: doc.data["eventDescription"] ?? ""
      );
    }).toList();
  }

  //Stream For event List

  Stream<List<Event>> get eventsList {
    return events.snapshots().map(_userEventListFromSnapshot);
  }


//-------------------------------------------------------------------------------

}
