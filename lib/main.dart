import 'package:flutter/material.dart';
import 'package:looking_for_apero/screens/models/user.dart';
import 'package:looking_for_apero/screens/wrapper.dart';
import 'package:looking_for_apero/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}