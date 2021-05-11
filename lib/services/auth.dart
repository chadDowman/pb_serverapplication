import 'package:firebase_auth/firebase_auth.dart';
import 'package:pb_blueprotocal/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    //If user != null then User(uid: user.uid) will be the return if not true return null
    return user != null
        ? User(uid: user.uid)
        : null; //This basically reads as follows: If the user object is not null do the following....
  }

  //Login User
  Future loginUser(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
    } catch (e) {
      print(
          "------------------------------------------------------------------------");
      print(e.toString());
      return null;
    }
  }

  //LogOut user
  Future registerUser(String username, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
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

  //Everytime USer signs in or out we will get a response via this event stream
  //Auth Change User Stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
}