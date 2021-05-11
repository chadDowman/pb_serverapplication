import 'package:firebase_auth/firebase_auth.dart';
import 'package:pb_blueprotocal/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    //If user != null then User(uid: user.uid) will be the return if not true return null
    return user != null ? User(uid: user.uid) : null; //This basically reads as follows: If the user object is not null do the following....
  }

  Future loginUser (String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);

    }catch(e){

    }
  }


}