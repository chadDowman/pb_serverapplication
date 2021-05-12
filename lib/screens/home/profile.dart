import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/shared/constants.dart';

class profile extends StatelessWidget {
  const profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            borderRadius: BorderRadius.circular(16)

                        ),

                        child: Row(
                          children: [
                            Container(
                              child: IconButton(
                                icon: const Icon(Icons.backspace_sharp),
                                color: Colors.white,
                                tooltip: 'Increase volume by 10',
                                onPressed: (){},

                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(''),
                              radius: 40,

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
                              contentPadding: const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Username',
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              hintStyle: kbod,
                            ),
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
                              contentPadding: const EdgeInsets.symmetric(vertical: 20),
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
                              ElevatedButton(onPressed: (){},
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
          )
          ,
        ),

      ],
    );
  }
}
