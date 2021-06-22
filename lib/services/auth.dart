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
    try{
      print("---------------------------------------Attempting to Send Password Reset email----------------------------------------------");
      await _auth.sendPasswordResetEmail(email: email);
      print("---------------------------------------Password Reset Email Sent Successfully----------------------------------------------");
    }catch(e){
      print("---------------------------------------Error Has Occurred Well Sending Password Reset Email----------------------------------------------");
      print(e.toString());
      print("---------------------------------------End of Password Reset Email Error----------------------------------------------");
    }

  }

  //Login User With Email and Password
  Future loginUser(String email, String password) async {
    try {
      print("---------------------------------------Starting User Login Attempt----------------------------------------------");
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if (user.isEmailVerified) {
        print("--------------------------------------Users Email is Verified----------------------------------------------");
        emailVerified = true;
      } else {
        print("---------------------------------------Users Email is NOT verified----------------------------------------------");
        emailVerified = false;
      }
      print("---------------------------------------User Successfully Logged In----------------------------------------------");
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("---------------------------------------An Error Has Occurred During User Login----------------------------------------------");
      print(e.toString());
      print("---------------------------------------End of Login Error Details----------------------------------------------");
      return null;
    }
  }

  //register user
  Future registerUser(String email, String password, String username, String imgUrl) async {
    try {
      print("---------------------------------------Starting User Registration Attempt----------------------------------------------");
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password); //Creates User
      print("---------------------------------------User Successfully Registered----------------------------------------------");
      FirebaseUser user = result.user; //Gets that user back
      try{
        print("---------------------------------------Attempting to send Email Verification----------------------------------------------");
        await user.sendEmailVerification(); //Sends email verification
        print("---------------------------------------User Email Verification Email Successfully Sent----------------------------------------------");
      }catch(e){
        print("---------------------------------------User Email does not exist----------------------------------------------");
        print(e.toString());
        print("---------------------------------------End of Email Verification Error----------------------------------------------");
      }
      try{
        //Create new Document for the user with the uid
        print("---------------------------------------Registering User Details With Firestore----------------------------------------------");
        await DatabaseService(uid: user.uid).updateUserData(username, "member", imgUrl); //Passes Uid to the constructor
        print("---------------------------------------User Details Successfully Registered With Firestore----------------------------------------------");
      }catch(e){
        print("---------------------------------------Error Has Occurred During Firestore Registration----------------------------------------------");
        print(e.toString());
        print("---------------------------------------End of Error During Firestore Registration----------------------------------------------");
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("---------------------------------------Error Has Occurred During User Registration----------------------------------------------");
      print(e.toString());
      print("---------------------------------------End of User Registration Error Report----------------------------------------------");
      return null;
    }
  }
}
