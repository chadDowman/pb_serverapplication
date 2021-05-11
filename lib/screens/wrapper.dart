import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/screens/authenticate/authenticate.dart';
import 'package:pb_blueprotocal/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context); // Accesses User Data from the provider
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}