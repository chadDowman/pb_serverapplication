import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/shared/constants.dart';

class event extends StatelessWidget {
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
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Divider(
                            height: 60,
                            color: Colors.grey[800],
                          ),
                          Text(
                            'Enter the name of the event',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Event Name',
                              prefixIcon: Icon(
                                Icons.drive_file_rename_outline,
                                color: Colors.white,
                              ),
                              hintStyle: kbod,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Describe the Event that is taking place',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 20),
                              border: InputBorder.none,
                              hintText: 'Description',
                              prefixIcon: Icon(
                                Icons.event,
                                color: Colors.white,
                              ),
                              hintStyle: kbod,
                            ),
                          ),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
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
          ),
        ),
      ],
    );
  }
}
