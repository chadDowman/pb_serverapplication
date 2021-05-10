import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggle;

  Register({this.toggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Sign up'),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        elevation: 0.0,
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Column(
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(20.0),
                    height: 70.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextButton(
                      onPressed: () {
                        widget.toggle();
                      },
                      child: Text('Sign In', style: TextStyle(color: Colors.black),),


                    ),
                  ),
                  Container(

                    height: 70.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: TextButton(
                      onPressed: () {
                        widget.toggle();
                      },
                      child: Text('Sign Up', style: TextStyle(color: Colors.black),),

                    ),
                  ),

                ],


              ),
              SizedBox(height: 20.0),
              Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50.0),

                  child:
                  //Username Field
                  TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(
                              10.0, 20.0, 0.0, 0.0),
                          hintText: "Username",
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      style: TextStyle(
                        color: Colors.blue,
                        letterSpacing: 2.0,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ))),

              //Email Field
              Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 50.0),
                  child:

                  TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(
                              10.0, 20.0, 0.0, 0.0),
                          hintText: "Email",
                          border:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      style: TextStyle(
                        color: Colors.blue,
                        letterSpacing: 2.0,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ))),

              SizedBox(height: 5.0),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                child:
                //Password Field
                TextFormField(

                  obscureText: true,

                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 4.0),
                      ),

                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 15.0, 20.0, 0.0),
                      hintText: "Password",
                      border:
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                ),),
              SizedBox(height: 5.0),

              //Confirm Password
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                child:
                //Password Field
                TextFormField(

                  obscureText: true,

                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink, width: 4.0),
                      ),

                      contentPadding: EdgeInsets.fromLTRB(
                          20.0, 15.0, 20.0, 0.0),
                      hintText: "Confirm Password",
                      border:
                      OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                ),),
              SizedBox(height: 50.0),

              //Container containing the login button
              Container(
                padding: EdgeInsets.all(0.0),
                child: FloatingActionButton.extended(
                  onPressed: (){
                  },
                  label: Text('Welcome to the Guild'),
                  icon: Icon(Icons.login),
                ),
              ),
              SizedBox(height: 5.0),
            ]),
      ),);
  }
}



