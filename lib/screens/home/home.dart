import 'package:flutter/material.dart';
import 'package:looking_for_apero/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Looking For Apéro'),
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
    );
  }
}