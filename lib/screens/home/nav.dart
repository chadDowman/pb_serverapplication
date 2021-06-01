import 'package:flutter/material.dart';
import 'package:pb_blueprotocal/models/event.dart';
import 'package:pb_blueprotocal/models/user.dart';
import 'package:pb_blueprotocal/screens/home/eventCreation.dart';
import 'package:pb_blueprotocal/screens/home/home.dart';
import 'package:pb_blueprotocal/screens/home/profile.dart';
import 'package:pb_blueprotocal/services/auth.dart';
import 'package:pb_blueprotocal/services/database.dart';
import 'package:pb_blueprotocal/shared/loading.dart';
import 'package:provider/provider.dart';

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
      if (index == 0) {
        screenName = "Home Screen";
      } else if (index == 1) {
        screenName = "Profile Screen";
      } else if (index == 2) {
        screenName = "Event Creation Screen";
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserAccountData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserAccountData userAccountData = snapshot.data;
            if (userAccountData.role == "admin") {
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.grey[800],
                  automaticallyImplyLeading: false,
                  title: Center(child: Text(screenName)),
                  elevation: 0.0,
                ),
                body: _widgetOptions.elementAt(_selectedIndex),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  selectedItemColor: Colors.deepPurple,
                  unselectedItemColor: Colors.red,
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
            } else {
              return Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  backgroundColor: Colors.grey[800],
                  automaticallyImplyLeading: false,
                  title: Center(child: Text(screenName)),
                  elevation: 0.0,
                ),
                body: _widgetOptions.elementAt(_selectedIndex),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  selectedItemColor: Colors.deepPurple,
                  unselectedItemColor: Colors.red,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text("Home"),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      title: Text('Profile'),
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _onItemTap,
                ),
              );
            }
          } else {
            return Loading();
          }
        });
  }
}
