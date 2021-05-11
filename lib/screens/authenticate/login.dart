import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:pb_blueprotocal/Widgets/backGroundImg.dart';

class Login extends StatefulWidget {
  final Function toggle;


  Login({this.toggle});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    height: 250,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,

                      child: Column(
                        children:[ Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                  border: InputBorder.none,
                                  hintText: 'Username or Email',
                                  prefixIcon: Icon(Icons.email,
                                  color: Colors.white,),
                                  hintStyle: kbod,
                                ),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[600].withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.lock,
                                    color: Colors.white,),

                                  hintStyle: kbod,
                                ),
                                obscureText: true,
                              ),
                            ),
                            TextButton(
                              onPressed: (){},
                              child: Text('Forget Password?',style: kbod,),
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
                  ),
                ],
              ),
            ),
          )
          ,
        ),

      ],
    );
  }
}
