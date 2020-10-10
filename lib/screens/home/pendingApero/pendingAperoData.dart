import 'package:flutter/material.dart';
import 'package:looking_for_apero/screens/models/eventData.dart';
import 'package:looking_for_apero/services/database.dart';
import 'package:looking_for_apero/shared/constants.dart';
import 'package:looking_for_apero/shared/loading.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:looking_for_apero/screens/models/event.dart';

class PendingAperoData extends StatefulWidget {
  @override
  _PendingAperoDataState createState() => _PendingAperoDataState();
}

class _PendingAperoDataState extends State<PendingAperoData> {
  final _formKey = GlobalKey<FormState>();

  String _name, _locationName, _desc;
  int _date;
  // Tags : tags

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context);
    return StreamBuilder<EventData>(
        stream: DatabaseService(uid: event.uid).eventData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            EventData eventData = snapshot.data;

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
                        Text('Basic Event settings'),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: _name ?? eventData.name,
                          decoration: textInputDecoration,
                          validator: (val) => val.isEmpty
                              ? 'please enter name of event name'
                              : null,
                          onChanged: (val) => setState(() => _name = val),
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          initialValue: _desc ?? eventData.description,
                          decoration: textInputDecoration,
                          validator: (val) => val.isEmpty
                              ? 'please enter description of event'
                              : null,
                          onChanged: (val) => setState(() => _desc = val),
                        ),
                        SizedBox(height: 20.0),
                        Text('Please location of event'),
                        TextFormField(
                          initialValue: _locationName ?? eventData.locationName,
                          decoration: textInputDecoration,
                          validator: (val) => val.isEmpty
                              ? 'please enter location Name of event'
                              : null,
                          onChanged: (val) => setState(() => _name = val),
                        ),
                        SizedBox(height: 20.0),
                        Text('Please date of event'),
                        NumberPicker.integer(
                          initialValue: _date ?? eventData.date,
                          minValue: 10,
                          maxValue: 100,
                          onChanged: (val) => setState(() => _date = val),
                        ),
                        RaisedButton(
                          child: Text('Save'),
                          elevation: 5,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await DatabaseService(uid: eventData.uid)
                                  .updateUserData(
                                // if _currentFirstName has a value use it otherwise use eventData.firstName
                                _name ?? eventData.name,
                                _desc ?? eventData.description,
                                _locationName ?? eventData.locationName,
                                _date ?? eventData.date,
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
