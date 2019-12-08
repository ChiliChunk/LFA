import 'package:flutter/material.dart';
import 'package:looking_for_apero/services/auth.dart';
import 'package:looking_for_apero/shared/constants.dart';
import 'package:looking_for_apero/shared/loading.dart';

// this class displays the register form 

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // store the sign in state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 10,
        title: Text('Sign up'),
        ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),

              // email
              TextFormField(
                // if no value then return error message
                // val = what's written in the field
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);                  
                },
                decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                ),
              ),
              SizedBox(height: 20.0),
              
              // password
              TextFormField(
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);                  
                },
                decoration: textInputDecoration.copyWith(
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),  
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.blue[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // check if form fields are populated
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'Please supply a valid email';
                        loading = false;
                      });
                    }
                    // Don't need a else because of the user stream already set up
                  }
                },
              ),            
              SizedBox(height: 20.0),
              InkWell(
                child: Text('Already registered ? Sign in'),
                onTap: () => widget.toggleView(),
              ),
            ],
          ),
        )
        ),
    );
  }
}