import 'package:firebase_auth/firebase_auth.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool emailVerified = false;

  //User Stream!
  //-------------------------------------------------------------------------------
  User _userFromFirebaseUser(FirebaseUser user) {
    //If user != null then User(uid: user.uid) will be the return if not true return null
    return user != null ? User(uid: user.uid) : null;
    //This basically reads as follows: If the user object is not null do the following....
  }

  // Everytime USer signs in or out we will get a response via this event stream
  // Auth Change User Stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //-------------------------------------------------------------------------------

  //Sends Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  //Login User With Email and Password
  Future loginUser(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;
      if (user.isEmailVerified) {
        print(
            "------------------------------------------------------------------------");
        print("USERS EMAIL IS VERIFIED");
        emailVerified = true;
      } else {
        print(
            "------------------------------------------------------------------------");
        print("USERS EMAIL IS NOT VERIFIED!!!!!!!!!!!!!!!!");
        emailVerified = false;
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(
          "------------------------------------------------------------------------");
      print(e.toString());
      return null;
    }
  }

  //register user
  Future registerUser(
      String email, String password, String username, String imgUrl) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password); //Creates User
      FirebaseUser user = result.user; //Gets that user back
      await user.sendEmailVerification(); //Sends email verification

      //Create new Document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
          username, "member", imgUrl); //Passes Uid to the constructor
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(
          "------------------------------------------------------------------------");
      print(e.toString());
      return null;
    }
  }

  //LogOut
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(
          "------------------------------------------------------------------------");
      print(e.toString());
      return null;
    }
  }

  getUserUID() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    return uid.toString();
  }
}
