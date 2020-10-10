import 'package:flutter/material.dart';
import 'package:looking_for_apero/screens/authenticate/authenticate.dart';
import 'package:looking_for_apero/screens/home/route.dart';
import 'package:looking_for_apero/screens/models/user.dart';
import 'package:looking_for_apero/screens/models/event.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // specify which stream we want to listen to
    final user = Provider.of<User>(context);
    final event = Provider.of<Event>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Router();
    }

    if (event == null) {
      return Router();
    } else {
      return Router();
    }
  }
}
