import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pb_blueprotocal/shared/constants.dart';
import 'package:pb_blueprotocal/Widgets/SignBackImg.dart';

class Register extends StatefulWidget {
  final Function toggle;

  Register({this.toggle});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
       SignBackImg(),
        Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
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
        Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
    child: Container(
    decoration: BoxDecoration(
    color: Colors.grey[600].withOpacity(0.5),
    borderRadius: BorderRadius.circular(16),

    ),
    child: TextFormField(
    decoration: InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 20),
    border: InputBorder.none,
    ),

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
    );

  }
}



