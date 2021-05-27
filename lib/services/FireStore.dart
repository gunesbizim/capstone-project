import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  final FirebaseFirestore _fireStore;

  FireStoreService(this._fireStore);

  Future<void> setUserData({ 
      required String id,
      required String name,
      required String email,
      String lastFlightId = "",
      String ppURL = "",
      String flightTime = "00:00:00"
      }) async {
    final CollectionReference pilotsRef = _fireStore.collection('pilots');
    Map<String, String> pilot = {
      "id": id,
      "fullName": name,
      "email": email,
      "lastFlightId": lastFlightId,
      "ppURL": ppURL,
      "flightTime": flightTime
    };
    await pilotsRef.doc(id).set(pilot);
  }
}
