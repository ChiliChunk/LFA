import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:looking_for_apero/screens/home/homePage/home.dart';
import 'package:looking_for_apero/screens/home/pendingApero/pendingAperoPage.dart';
import 'package:looking_for_apero/screens/home/userProfile/userProfilePage.dart';

import 'package:looking_for_apero/services/auth.dart';

// Routing class
class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> {
  final AuthService _auth = AuthService();
  int _index = 0;
  final _pageOptions = [
    // Home(),
    Home(),
    PendingAperoPage(),
    UserProfilePage(),
    UserProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        bottomNavigationBar: CurvedNavigationBar(
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.event, size: 30),
            Icon(Icons.event_available, size: 30),
            Icon(Icons.info, size: 30),
          ],
          color: Colors.white,
          backgroundColor: Colors.blue[100],
          animationCurve: Curves.easeOutCubic,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
          height: 50.0,
        ),
        appBar: AppBar(
          title: Text('Looking For Apéro'),
          backgroundColor: Colors.blue[500],
          elevation: 10,
          actions: <Widget>[
            FlatButton.icon(
              label: Text('Logout'),
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          splashColor: Colors.blue[700],
          onPressed: () {
            // _btnColor = Colors.red;
            print('Open the form to create an Apero');
          },
        ),
        body: _pageOptions[_index],
        // backgroundColor: Colors.red[500],
        // body: Container(
        //   child: UserProfilePage(),
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //       stops: [0.1, 0.5, 0.7, 0.9],
        //       colors: [
        //         // Colors are easy thanks to Flutter's Colors class.
        //         Colors.blue[300],
        //         Colors.blue[400],
        //         Colors.blue[500],
        //         Colors.blue[600],
        //       ],
        //     ),
        //     // image: DecorationImage(
        //     //   image: AssetImage('assets/bg2.jpg'),
        //     //   fit: BoxFit.cover,
        //     // )
        //   ),
        // ),
      ),
    );
  }
}
