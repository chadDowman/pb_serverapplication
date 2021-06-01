import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pb_blueprotocal/screens/authenticate/login.dart';
import 'package:pb_blueprotocal/services/auth.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:pb_blueprotocal/Widgets/forgetBackImg.dart';
import 'package:pb_blueprotocal/shared/loading.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth = AuthService(); // Instance of auth service class
  final _formKey = GlobalKey<FormState>();
  String email = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Stack(
            children: [
              forgetImg(),
              Scaffold(
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.grey[600].withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: Form(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              border: InputBorder.none,
                                              hintText: 'Email',
                                              prefixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Icon(
                                                  Icons.login,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                              hintStyle: kbod,
                                            ),
                                            style: kbod,
                                            validator: (val) => val.isEmpty
                                                ? "Enter A Valid Email!"
                                                : null,
                                            onChanged: (val) {
                                              setState(() {
                                                email = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Remember your password? Sign in',
                                        style: kbod,
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
                                      child: FlatButton(
                                        onPressed: () async {
                                          if (_formKey.currentState
                                              .validate()) {
                                            setState(() {
                                              loading = true;
                                            });
                                            try {
                                              await _auth
                                                  .sendPasswordResetEmail(
                                                      email);
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Password Reset Email Sent");
                                              loading = false;
                                              Navigator.pop(context);
                                            } catch (e) {
                                              loading = false;
                                              print(
                                                  "------------------------------------------------------------------------------------------------");
                                              print("EMAIL DOES NO EXIST");
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          child: Text(
                                            'Submit',
                                            style: kbod,
                                          ),
                                        ),
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
                  ),
                ),
              ),
            ],
          );
  }
}
