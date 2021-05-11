import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:pb_blueprotocal/Widgets/backGroundImg.dart';
import 'package:pb_blueprotocal/Widgets/Email.dart';
import 'package:pb_blueprotocal/Widgets/Password.dart';
class Login extends StatefulWidget {
  final Function toggle;

  Login({this.toggle});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroungImg(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  child: Center(
                    child:
                    Text('Login', style: kHead,),

                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 50),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16)

                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: FlatButton(
                              onPressed: (){
                                widget.toggle();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text('Sign In', style: kbod,),
                              ),
                            ),
                          ),
                          Container(
                            child: FlatButton(
                              onPressed: (){
                                widget.toggle();
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text('Sign Up', style: kbod,),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children:[ Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextInput(
                          icon: Icons.email,
                          hint: 'Username or Email',
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                        ),
                        PasswordInput(
                          icon: Icons.lock,
                          hint: 'Password',
                          inputAction: TextInputAction.done,
                        ),
                        Text('ForgetPassword?',
                          style: kbod,),
                      ],
                    ),
                      Column(
                        children: [
                          SizedBox(height: 50),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(16)

                            ),
                            child: FlatButton(
                              onPressed: (){

                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Text('Login', style: kbod,),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],),
                ),
              ],
            ),
          )
          ,
        ),

      ],
    );
  }
}
