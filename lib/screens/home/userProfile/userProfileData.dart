import 'package:flutter/material.dart';
import 'package:looking_for_apero/screens/models/userData.dart';
import 'package:looking_for_apero/services/database.dart';
import 'package:looking_for_apero/shared/constants.dart';
import 'package:looking_for_apero/shared/loading.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:looking_for_apero/screens/models/user.dart';

class UserProfileData extends StatefulWidget {
  @override
  _UserProfileDataState createState() => _UserProfileDataState();
}

class _UserProfileDataState extends State<UserProfileData> {
  final _formKey = GlobalKey<FormState>();

  String _currentFirstName, _currentLastName, _currentBio;
  int _currentAge;

  @override
  Widget build(BuildContext context) {
    // ['acFDQymXHafgiYFYsNefCDypUzF2']);

    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.blue[100],
                body: SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                    // alignment: Alignment.topLeft,
                    child: Column(
                      children: <Widget>[
                        // Container(
                        //   child: Text(userData.firstName + '\n' +userData.lastName),
                        // ),
                        Text('Basic user settings'),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: _currentFirstName ?? userData.firstName,
                          decoration: textInputDecoration,
                          validator: (val) => val.isEmpty
                              ? 'please enter your first name'
                              : null,
                          onChanged: (val) =>
                              setState(() => _currentFirstName = val),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: _currentLastName ?? userData.lastName,
                          decoration: textInputDecoration,
                          validator: (val) => val.isEmpty
                              ? 'please enter your last name'
                              : null,
                          onChanged: (val) =>
                              setState(() => _currentLastName = val),
                        ),
                        SizedBox(height: 20.0),
                        Text('Please select your age'),
                        NumberPicker.integer(
                          initialValue: _currentAge ?? userData.age,
                          minValue: 10,
                          maxValue: 100,
                          onChanged: (val) => setState(() => _currentAge = val),
                        ),
                        SizedBox(height: 20.0),
                        Text('Bio'),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: _currentBio ?? userData.bio,
                          decoration: new InputDecoration(
                            hintText: 'tell more about you...',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          onChanged: (val) => setState(() => _currentBio = val),
                        ),
                        SizedBox(height: 50.0),

                        RaisedButton(
                          child: Text('Save'),
                          elevation: 5,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await DatabaseService(uid: userData.uid)
                                  .updateUserData(
                                // if _currentFirstName has a value use it otherwise use userData.firstName
                                _currentFirstName ?? userData.firstName,
                                _currentLastName ?? userData.lastName,
                                _currentBio ?? userData.bio,
                                _currentAge ?? userData.age,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
