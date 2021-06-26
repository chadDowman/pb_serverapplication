import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/screens/authenticate/login.dart';
import 'package:pb_blueprotocal/services/auth.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:pb_blueprotocal/services/deleteUser.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:pb_blueprotocal/shared/loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userUID;
  String username;
  String usernameForField;
  String imageUrlGet;
  String imageUrl;
  String email;
  String password;
  UserAccountData outObjectUserAccount;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService(); // Instance of auth service class
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool accountDeleted = false;
  bool deleteAlert = false;

  // Accesses User Data from the provider

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final BuildContext profileContext = context;
    print(
        'I RAN AGAIN !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    if (accountDeleted == true) {
      accountDeleted = false;
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => Login(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    }

    // set up the buttons
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () async{
        accountDeleted = true;
        print( "---------------------------------------Account Deletion Button Clicked----------------------------------------------");
        await DeleteService(uid: userUID, context: profileContext).deleteUserAuth();
        Fluttertoast.showToast(msg: "Account Deleted Successfully");
        setState(() {
          deleteAlert = false;
        });
      },
    );
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        setState(() {
          deleteAlert = false;
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("ALERT!"),
      content: Text("Are you sure you want to delete your account ?"),
      actions: [
        yesButton,
        noButton,
      ],
    );

    if (deleteAlert == true) {
      return alert;
    } else {
      return user == null
          ? Loading()
          : StreamBuilder<UserAccountData>(
              stream: DatabaseService(uid: user.uid).userData,
              builder: (context, snapshot) {
                if (accountDeleted == true) {
                  print(
                      'INSIDE STREAM!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
                } else {}
                if (snapshot.data != null && snapshot.hasData) {
                  UserAccountData userAccountData = snapshot.data;
                  outObjectUserAccount = userAccountData;
                  userUID = user.uid;
                  return Stack(
                    children: [
                      Scaffold(
                        backgroundColor: Colors.grey[900],
                        body: SingleChildScrollView(
                          child: SafeArea(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Center(
                                          child: InkWell(
                                            onTap: () {
                                              print(
                                                  "---------------------------------------Image Upload Process Has Begun----------------------------------------------");
                                              dynamic uploadIMG = uploadImage();
                                              if (uploadIMG) {
                                                print(
                                                    "---------------------------------------Image Successfully Uploaded----------------------------------------------");
                                              } else {
                                                print(
                                                    "---------------------------------------An Error Has Occurred During Image Upload----------------------------------------------");
                                              }
                                            },
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  userAccountData.imgUrl),
                                              radius: 40,
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 60,
                                          color: Colors.grey[800],
                                        ),
                                        Text(
                                          'Name',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            letterSpacing: 2,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20),
                                            border: InputBorder.none,
                                            hintText: 'Username',
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: Colors.white,
                                            ),
                                            hintStyle: kbod,
                                          ),
                                          validator: (val) => val.isEmpty
                                              ? "Enter A Username!"
                                              : null,
                                          onChanged: (val) {
                                            setState(() {
                                              usernameForField = val;
                                            });
                                          },
                                        ),
                                        SizedBox(height: 30),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 90,
                                                    vertical: 10,
                                                  ),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),
                                                          side: BorderSide(color: Colors.purpleAccent))),
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                              Colors.grey[800]),
                                                    ),
                                                    onPressed: () async {
                                                      if (_formKey.currentState
                                                          .validate()) {
                                                        await changeUsername();
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                      child: Text(
                                                        'Change',
                                                        style: butt,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 70,
                                                      vertical: 10,
                                                    ),
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),
                                                            side: BorderSide(color: Colors.purpleAccent))),
                                                        backgroundColor:
                                                            MaterialStateProperty.all(
                                                                Colors.grey[800]),
                                                      ),
                                                      onPressed: () async {
                                                        print('Delete Button Clicked');
                                                        setState(() {deleteAlert = true;});
                                                      },
                                                      child: Text(
                                                        'Delete account',
                                                        style: butt,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        floatingActionButton: FloatingActionButton.extended(
                          onPressed: () async {
                            Fluttertoast.showToast(
                                msg: "You have successfully Logged Out");
                            await Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => Login(),
                              ),
                              (route) =>
                                  false, //if you want to disable back feature set to false
                            );
                            await signOut();

                            // Calls sign out function
                          },
                          label: Text('Logout'),
                          icon: Icon(Icons.logout),
                          backgroundColor: Colors.pink,
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  print(
                      '-------------------ERROR HAS OCCURRED HERES THE LOGIN PAGE LMAO');
                  return Login();
                } else {
                  return Loading();
                }
              });
    }
  }

  changeUsername() async {
    try {
      print(
          "---------------------------------------Attempting to change Username----------------------------------------------");
      await DatabaseService(uid: userUID).updateUserData(usernameForField,
          outObjectUserAccount.role, outObjectUserAccount.imgUrl);
      print(
          "---------------------------------------Username Changed Successfully----------------------------------------------");
      Fluttertoast.showToast(msg: "Username Successfully Updated");
    } catch (e) {
      print(
          "---------------------------------------Error Has Occurred During Username Change----------------------------------------------");
      print(e.toString());
      print(
          "---------------------------------------End of Username Error Report----------------------------------------------");
    }
  }

  signOut() async {
    try {
      print(
          "---------------------------------------Attempting to Log Out User----------------------------------------------");
      await FirebaseAuth.instance.signOut();
      print(
          "---------------------------------------User Logout Successful----------------------------------------------");
    } catch (e) {
      print(
          "---------------------------------------An Error Has Occurred During User Logout----------------------------------------------");
      print(e.toString());
      print(
          "---------------------------------------End of User Logout Error Report----------------------------------------------");
    }
  }

  uploadImage() async {
    try {
      final _storage = FirebaseStorage.instance;
      final _picker = ImagePicker();
      PickedFile image;

      // Check Permissions
      await Permission.photos.request();
      var permissionStatus = await Permission.photos.status;

      if (permissionStatus.isGranted) {
        //Select Image
        image = await _picker.getImage(source: ImageSource.gallery);
        var file = File(image.path);

        if (image != null) {
          //Upload to Firebase
          var snapshot = await _storage
              .ref()
              .child("Pixelated_Bros/" + userUID)
              .putFile(file)
              .onComplete;
          var downloadUrl = await snapshot.ref.getDownloadURL();
          imageUrl = downloadUrl;
          await DatabaseService(uid: userUID).updateUserData(
              outObjectUserAccount.username, "member", imageUrl);
          return true;
        } else {
          Fluttertoast.showToast(msg: "Image Error");
        }
      } else {
        Fluttertoast.showToast(msg: "Permissions not granted try again");
      }
    } catch (e) {
      print(
          "---------------------------------------Image Upload Error Report----------------------------------------------");
      print(e);
      print(
          "---------------------------------------End of Image Upload Error Report----------------------------------------------");
      return false;
    }
  }
}

//What could have been
//"--------------------------------------------------------------------------------------------------------------------------"
// getUserUID() async {
//   final FirebaseUser user = await _auth.currentUser();
//   final uid = user.uid;
//   userUID = uid.toString();
// }

// Future getUsersList() async {
//   await getUserUID();
//   await userInfo.document(userUID).get().then((value) {
//     username = value.data["username"];
//     imageUrlGet = value.data["imgUrl"];
//     print(username);
//     print(imageUrlGet);
//   }).catchError((e) {
//     print("------------------------------------------");
//     print(e);
//   });
// }

// showImage() async {
//   final ref =
//       FirebaseStorage.instance.ref().child("Pixelated_Bros/" + userUID);
//   var url = await ref.getDownloadURL();
//
//   print(url);
// }
//"--------------------------------------------------------------------------------------------------------------------------"
