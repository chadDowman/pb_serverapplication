import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function toggle;

  Login({this.toggle});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(

        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Container(

        child: Column(
            children: <Widget>[
              Image(image: AssetImage('pics/b.png')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //Sign in button
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

                  //Sign up button
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
              //Container for the Username and Password Fields
              Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child:

                  //Username Field
                  TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
                          hintText: "Username",
                          border:
                          OutlineInputBorder(borderRadius: BorderRadius.circular(40.0)))
                      ,
                      style: TextStyle(
                        color: Colors.blue,
                        letterSpacing: 2.0,

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

                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      hintText: "Password",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
                ),),

              SizedBox(height: 10.0),

              //Container containing the login button
              Container(
                padding: EdgeInsets.all(0.0),
                child: FloatingActionButton.extended(
                  onPressed: (){
                  },
                  label: Text('Login to the Guild'),
                  icon: Icon(Icons.login),
                ),
              ),
              SizedBox(height: 5.0),

              //Container that Contaning the Forgot password button
              Container(
                padding: EdgeInsets.all(10.0),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    widget.toggle();
                  },
                  label: Text('Forget Thee Password?'),
                ),
              ),
            ]),
      ),
    );
  }
}
