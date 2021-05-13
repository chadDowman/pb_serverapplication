import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/screens/authenticate/forgotPass.dart';
import 'package:pb_blueprotocal/screens/authenticate/register.dart';
import 'package:pb_blueprotocal/screens/home/home.dart';
import 'package:pb_blueprotocal/services/auth.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:pb_blueprotocal/Widgets/backGroundImg.dart';
import 'package:pb_blueprotocal/shared/loading.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService(); // Instance of auth service class
  final _formKey = GlobalKey<FormState>();

  //Text Field States
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Stack(
            children: [
              BackgroungImg(),
              Scaffold(
                backgroundColor: Colors.transparent,
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
                                color: Colors.blue,
                              ),
                              child: Row(
                                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Text(
                                          '',
                                          style: kbod,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => Register()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: Text(
                                          'Sign Up',
                                          style: kbod,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
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
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.grey[600].withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 20),
                                          border: InputBorder.none,
                                          hintText: 'Username or Email',
                                          prefixIcon: Icon(
                                            Icons.email,
                                            color: Colors.white,
                                          ),
                                          hintStyle: kbod,
                                        ),
                                        validator: (val) => val.isEmpty
                                            ? "Enter An Email!"
                                            : null,
                                        onChanged: (val) {
                                          setState(() {
                                            email = val;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.grey[600].withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextFormField(
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
                                        validator: (val) => val.length < 8
                                            ? "Enter a password with 6 or longer"
                                            : null,
                                        obscureText: true,
                                        onChanged: (val) {
                                          setState(() {
                                            password = val;
                                          });
                                        },
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgotPassword()));
                                      },
                                      child: Text(
                                        'Forget Password?',
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
                                            dynamic result = await _auth
                                                .loginUser(email, password);
                                            if (result == null) {
                                              setState(() {
                                                error = "Invalid Credentials";
                                                loading = false;
                                              });
                                            } else {
                                              loading = false;
                                              if (_auth.emailVerified) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Home()));
                                              } else {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Login()));
                                              }
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          child: Text(
                                            'Login',
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
  }
}
