import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:looking_for_apero/screens/home/userProfile.dart/userProfilePage.dart';
import 'package:looking_for_apero/screens/models/userData.dart';
import 'package:looking_for_apero/services/auth.dart';
import 'package:looking_for_apero/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
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
        body: Container(
          child: UserProfilePage(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.5, 0.7, 0.9],
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                Colors.blue[300],
                Colors.blue[400],
                Colors.blue[500],
                Colors.blue[600],
              ],
            ),
            // image: DecorationImage(
            //   image: AssetImage('assets/bg2.jpg'),
            //   fit: BoxFit.cover,
            // )
          ),
          ),
      ),
    );
  }
}