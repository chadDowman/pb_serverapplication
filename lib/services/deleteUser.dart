import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeleteService {
  final uid;
  final context;

  DeleteService({this.uid, this.context}); // Constructor

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userInfo =
      Firestore.instance.collection("Guild_Members");

  //Delete User Data Firestore
  Future _userDeleteAccount() async {
    try {
      return await userInfo.document(uid).delete();
    } catch (e) {
      print(
          "---------------------------------------Error Has Occurred During Firestore Deletion----------------------------------------------");
      print(e.toString());
      print(
          "---------------------------------------End of Error During Firestore Deletion----------------------------------------------");
    }
  }

  Future _userDeleteAuth() async {
    try {
      final FirebaseUser user = await _auth.currentUser();
      return await user.delete();
    } catch (e) {
      print(
          "---------------------------------------Error Has Occurred During Firebase Auth Deletion----------------------------------------------");
      print(e.toString());
      print(
          "---------------------------------------End of Error During Firebase Auth Deletion----------------------------------------------");
    }
  }

  Future deleteUserAuth() async {
    try {
      print(
          "---------------------------------------Starting Firestore Deletion----------------------------------------------");
      await _userDeleteAccount();
      print(
          "------------------------------------------Firestore Deletion Successful-------------------------------------------");
      print(
          "------------------------------------------Starting Firebase Auth Deletion-------------------------------------------");
      _userDeleteAuth();
      print(
          "------------------------------------------Firebase Auth Deletion Successful-------------------------------------------");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
