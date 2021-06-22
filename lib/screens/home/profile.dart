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

  // Accesses User Data from the provider

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return user == null
        ? Loading()
        : StreamBuilder<UserAccountData>(
            stream: DatabaseService(uid: user.uid).userData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
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
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                        ),
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                await changeUsername();
                                              }
                                            },
                                            child: Padding(
                                              padding:

                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0),
                                              child: Text(
                                                'Change',
                                                style: butt2,
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
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
                                              ),
                                              onPressed: () async {
                                                print(
                                                    "---------------------------------------Account Deletion Button Clicked----------------------------------------------");
                                                dynamic delete =
                                                    await DatabaseService(
                                                            uid: userUID)
                                                        .deleteUserAuth();
                                                if (delete) {
                                                  Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Account Successfully Deleted");
                                                  print(
                                                      "---------------------------------------Account Deletion Button Click Finished Processes Successfully----------------------------------------------");
                                                } else {
                                                  print(
                                                      "---------------------------------------Account Deletion Error Has Occurred----------------------------------------------");
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Error Has Occurred During Account Deletion");
                                                }
                                              },
                                              child: Text(
                                                'Delete account',
                                                style: butt2,
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
                      floatingActionButton: FloatingActionButton.extended(
                        onPressed: () async {

                          Navigator.push(context,MaterialPageRoute(builder: (context) => Login()));
                          await _auth.logOut(); // Calls sign out function
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
    try{
      print("---------------------------------------Attempting to change Username----------------------------------------------");
      await DatabaseService(uid: userUID).updateUserData(usernameForField, outObjectUserAccount.role, outObjectUserAccount.imgUrl);
      print("---------------------------------------Username Changed Successfully----------------------------------------------");
      Fluttertoast.showToast(msg: "Username Successfully Updated");
    }catch(e){
      print("---------------------------------------Error Has Occurred During Username Change----------------------------------------------");
      print(e.toString());
      print("---------------------------------------End of Username Error Report----------------------------------------------");
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
      print("---------------------------------------Image Upload Error Report----------------------------------------------");
      print(e);
      print("---------------------------------------End of Image Upload Error Report----------------------------------------------");
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
