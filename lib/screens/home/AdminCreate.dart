import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pb_blueprotocal/screens/authenticate/login.dart';
import 'package:pb_blueprotocal/services/auth.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:pb_blueprotocal/Widgets/SignBackImg.dart';
import 'package:pb_blueprotocal/shared/loading.dart';

class AdminCreation extends StatefulWidget {
  const AdminCreation({Key key}) : super(key: key);

  @override
  _AdminCreationState createState() => _AdminCreationState();
}

class _AdminCreationState extends State<AdminCreation> {
  final AuthService _auth = AuthService(); // Instance of auth service class
  final _formKey = GlobalKey<FormState>();

  //Text Field States
  String email = "";
  String password = "";
  String passwordConfirm = "";
  String username = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Stack(
            children: [
              SignBackImg(),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[600]
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              border: InputBorder.none,
                                              hintText: 'Enter Username',
                                              prefixIcon: Icon(
                                                Icons.verified_user,
                                                color: Colors.white,
                                              ),
                                              hintStyle: kbod,
                                            ),
                                            validator: (val) => val.isEmpty
                                                ? "Enter A Username!"
                                                : null,
                                            onChanged: (val) {
                                              setState(() {
                                                username = val;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[600]
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              border: InputBorder.none,
                                              hintText: 'Enter Email',
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.white,
                                              ),
                                              hintStyle: kbod,
                                            ),
                                            validator: (val) => val.isEmpty
                                                ? "Enter An Email!"
                                                : null,
                                            // return val.isEmpty ? "Enter An Email!" : null;//Return Operator
                                            onChanged: (val) {
                                              setState(() {
                                                email = val;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[600]
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              border: InputBorder.none,
                                              hintText: 'Enter Password',
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: Colors.white,
                                              ),
                                              hintStyle: kbod,
                                            ),
                                            validator: (val) => val.length < 8
                                                ? "Enter a password with 8 characters or longer!"
                                                : null,
                                            // return val.isEmpty ? "Enter An Email!" : null;//Return Operator
                                            obscureText: true,
                                            onChanged: (val) {
                                              setState(() {
                                                password = val;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[600]
                                                .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              border: InputBorder.none,
                                              hintText: 'Re-Enter Password',
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: Colors.white,
                                              ),
                                              hintStyle: kbod,
                                            ),
                                            validator: (val) => val != password
                                                ? "Password MisMatch"
                                                : null,
                                            obscureText: true,
                                            onChanged: (val) {
                                              setState(() {
                                                passwordConfirm = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(height: 50),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: BorderSide(
                                                          color: Colors
                                                              .purpleAccent))),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.grey[800]),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                setState(() {
                                                  loading = true;
                                                });
                                                email = email.trim();
                                                username = username.trim();
                                                dynamic result =
                                                    await _auth.registerAdmin(
                                                        email,
                                                        password,
                                                        username,
                                                        "https://static0.cbrimages.com/wordpress/wp-content/uploads/2020/07/Rem-re-zero-promo-Cropped.jpg");
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Admin User Created Successfully");
                                                if (result == null) {
                                                  setState(() {
                                                    error =
                                                        "Please Supply a Valid Email or Password";
                                                    loading = false;
                                                  });
                                                } else {
                                                  loading = false;
                                                }
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16.0),
                                              child: Text(
                                                'Create Admin',
                                                style: kbod,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          error,
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
