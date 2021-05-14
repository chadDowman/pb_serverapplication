import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/screens/home/eventCreation.dart';
import 'package:pb_blueprotocal/screens/home/home.dart';
import 'package:pb_blueprotocal/screens/home/profile.dart';
import 'package:pb_blueprotocal/services/auth.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}
//Remeber to fix passing null username values and access roles
class _NavState extends State<Nav> {
  String screenName = "Home Screen";
  int _selectedIndex = 0;
  final AuthService _auth = AuthService(); // Instance of auth service class
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Profile(),
    EventCreation(),
  ];

  void _onItemTap(int index) {
    setState(() {
      if(index == 0){
        screenName = "Home Screen";
      }else if(index == 1){
        screenName = "Profile Screen";
      }else if(index == 2){
        screenName = "Event Creation Screen";
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text(screenName)),
        elevation: 0.0,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            title: Text('Event Creation'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
