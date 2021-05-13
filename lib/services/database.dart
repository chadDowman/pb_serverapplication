import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:permission_handler/permission_handler.dart';

class DatabaseService {
  final String uid;

  //Collection reference
  //Reference to a specific collection in firestore database
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


}
