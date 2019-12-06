import 'package:flutter/material.dart';
import 'package:looking_for_apero/screens/authenticate/register.dart';
import 'package:looking_for_apero/screens/authenticate/sign_in.dart';

// this class displays either the login or sign up page

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool showSignIn = true;
  
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }else {
      return Register(toggleView: toggleView);
    }
  }
}