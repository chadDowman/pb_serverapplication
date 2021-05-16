import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/screens/authenticate/login.dart';
import 'package:pb_blueprotocal/services/auth.dart';
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

  // Accesses User Data from the provider

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService(); // Instance of auth service class

    final _formKey = GlobalKey<FormState>();

    print("------------PROVIDER UID----------------------");
    return user == null ? Loading() : StreamBuilder<UserAccountData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (user.uid != null) {
              print("------------PROVIDER UID----------------------");
              print("ITS NOT NULL");
            } else {
              print("------------PROVIDER UID----------------------");
              print("ITS NULL");
            }
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
                      validator: (val) =>
                      val.isEmpty
                          ? "Enter A Username!"
                          : null,
                      onChanged: (val) {
                        setState(() {
                          usernameForField = val;
                        });
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
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
                    Column(
                      children: [
                        SizedBox(height: 50),
                        Container(
                          height: 60,
                          width: 88,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                              BorderRadius.circular(16)),
                          child: FlatButton(
                            onPressed: () {},
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
                ),

                      ),],
            ),
          ),
          ),
          floatingActionButton: FloatingActionButton.extended(
          onPressed: () async{
          await _auth.logOut(); // Calls sign out function
          Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
          },
          label: Text('Logout'),
          icon: Icon(Icons.logout),
          backgroundColor: Colors.pink,
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
    await DatabaseService(uid: userUID).updateUserData(
        usernameForField, "member", outObjectUserAccount.imgUrl);

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
              .updateUserData(
              outObjectUserAccount.username, "member", imageUrl);
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
      print(
          "--------------------------------------------------------------------------------------------------------------------------");
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
