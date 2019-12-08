import 'package:flutter/material.dart';


class PendingApero extends StatefulWidget {
  @override
  _PendingAperoState createState() => _PendingAperoState();
}

class _PendingAperoState extends State<PendingApero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          alignment: Alignment.topCenter,
          // color: Colors.blue,
          child: Text('Hello, i\'m the pending apero page'),
      ),
    );
  }
}