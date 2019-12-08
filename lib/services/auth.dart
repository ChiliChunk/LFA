import 'package:firebase_auth/firebase_auth.dart';
import 'package:looking_for_apero/screens/models/user.dart';
import 'package:looking_for_apero/services/database.dart';

// this class implements all sign in and log in methods

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FireBaseUser
  User _userFromFireBaseUser (FirebaseUser user) {
    // if user not equal to null then return User else, return null
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream : allows to know if the user is signed in or not
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFireBaseUser);
  }

  // Sign in Anonym
  Future signInAnon() async {
    try{
      AuthResult result =  await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign in email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email:email, password: password);
      FirebaseUser user = result.user;

      return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email:email, password: password);
      FirebaseUser user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('firstName', 'lastName', 'bio', 10);
      return _userFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign in Google

  // Sign in Facebook

  // Sign in Twitter

}