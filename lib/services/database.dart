import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pb_blueprotocal/models/user.dart';

class DatabaseService {

  final String uid;
  //Collection reference
  //Reference to a specific collection in firestore database
  DatabaseService({this.uid});

  //Creates if not created and makes the database reference
  final CollectionReference userInfo = Firestore.instance.collection("Guild_Members");

  //Sets User Data
  Future updateUserData (String username, String role) async{
    return await userInfo.document(uid).setData({
      "username": username,
      "role": role,
    });
  }

  // Gets User Details Via Stream

  UserAccount _userAccountDataFromSnapShot (DocumentSnapshot snapshot){
    return UserAccount(
      uid: uid,
      username: snapshot.data["username"],
      role: snapshot.data["role"],
    );
  }

  Stream<UserAccount> get userData {
    return userInfo
        .document(uid)
        .snapshots()
        .map(_userAccountDataFromSnapShot); // UID says which document to get
  }



}