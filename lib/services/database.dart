import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:looking_for_apero/screens/models/eventData.dart';
import 'package:looking_for_apero/screens/models/userData.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userDataCollection =
      Firestore.instance.collection('userData');
  final CollectionReference eventDataCollection =
      Firestore.instance.collection('eventData');

  // create or modify a userData collection with the uid
  Future updateUserData(
      String firstName, String lastName, String bio, int age) async {
    return await userDataCollection.document(uid).setData({
      'firstName': firstName,
      'lastName': lastName,
      'bio': bio,
      'age': age,
    });
  }

  // get userData stream
  // Stream<QuerySnapshot> get userData {
  //   return userDataCollection.snapshots();
  // }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      firstName: snapshot.data['firstName'],
      lastName: snapshot.data['lastName'],
      bio: snapshot.data['bio'],
      age: snapshot.data['age'],
    );
  }

  EventData _eventDataFromSnapshot(DocumentSnapshot snapshot) {
    return EventData(
      uid: uid,
      name: snapshot.data['name'],
      description: snapshot.data['description'],
      locationName: snapshot.data['locationName'],
      date: snapshot.data['date'],
      lat: snapshot.data['lat'],
      lon: snapshot.data['lon'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userDataCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  // get user doc stream
  Stream<EventData> get eventData {
    return userDataCollection
        .document(uid)
        .snapshots()
        .map(_eventDataFromSnapshot);
  }
}
