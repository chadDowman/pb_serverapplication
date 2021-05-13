import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:pb_blueprotocal/shared/loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

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
  UserAccountData outObjectUserAccount;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userInfo =
      Firestore.instance.collection("Guild_Members");

  final _formKey = GlobalKey<FormState>();


  // Accesses User Data from the provider

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    userUID = user.uid;
    print("------------PROVIDER UID----------------------");
    print(user.uid);
    print(userUID);

    return StreamBuilder<UserAccountData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserAccountData userAccountData = snapshot.data;
            outObjectUserAccount = userAccountData;
            return Stack(
              children: [
                Scaffold(
                  backgroundColor: Colors.grey[900],
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 0),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                  children: [
                                    Container(
                                      child: IconButton(
                                        icon: const Icon(Icons.backspace_sharp),
                                        color: Colors.white,
                                        tooltip: 'Increase volume by 10',
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: InkWell(
                                      onTap: () => uploadImage(),
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(userAccountData.imgUrl),
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
                                  SizedBox(height: 10),
                                  Text(
                                    'Surname',
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
                                      hintText: 'Password',
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                      ),
                                      hintStyle: kbod,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            await changeUsername();
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          child: Text(
                                            'Change',
                                            style: kbod,
                                          ),
                                        ),
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
                ),
              ],
            );
          } else {
            return Loading();
          }
        });
  }

  changeUsername() async {
    await DatabaseService(uid: userUID)
        .updateUserData(usernameForField, "member", outObjectUserAccount.imgUrl);
    Fluttertoast.showToast(msg: "Username Successfully Updated");
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
          await DatabaseService(uid: userUID)
              .updateUserData(outObjectUserAccount.username, "member", imageUrl);
        } else {
          Fluttertoast.showToast(msg: "Image Error");
        }
      } else {
        Fluttertoast.showToast(msg: "Permissions not granted try again");
      }
    } catch (e) {
      print(
          "--------------------------------------------------------------------------------------------------------------------------");
      print(e);
      print("--------------------------------------------------------------------------------------------------------------------------");

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
