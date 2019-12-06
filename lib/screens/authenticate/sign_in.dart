import 'package:flutter/material.dart';
import 'package:looking_for_apero/screens/authenticate/register.dart';
import 'package:looking_for_apero/services/auth.dart';

// this class displays the signIn form

class SignIn extends StatefulWidget {

  final Function toggleView;

  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // store the sign in state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 10,
        title: Text('Sign in'),
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
                onChanged: (val){
                  setState(() => email = val);                  
                },
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                decoration: InputDecoration(
                  hintText: 'Email'
                ),
              ),
              SizedBox(height: 20.0),

              // Password
              TextFormField(
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);                  
                },
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                decoration: InputDecoration(
                  hintText: 'Password'
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
                  'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() => error = 'Email or password incorrect');
                    }
                    // Don't need a else because of the user stream already set up
                  }
                },
              ),
              SizedBox(height: 20.0),
              InkWell(
                child: Text('Not registered yet ?'),
                onTap: () => widget.toggleView(),
              ),
            ],
          ),
        )
      ),
    );
  }
}