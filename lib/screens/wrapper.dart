import 'package:flutter/material.dart';
import 'package:looking_for_apero/screens/authenticate/authenticate.dart';
import 'package:looking_for_apero/screens/home/home.dart';
import 'package:looking_for_apero/screens/models/user.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // specify which stream we want to listen to
    final user = Provider.of<User>(context);
    
    if(user == null){
      return Authenticate();
    }else {
      return Home();
    }
  }
}