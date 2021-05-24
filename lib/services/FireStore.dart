import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreService {
  final FirebaseFirestore _fireStore;

  FireStoreService(this._fireStore);

  Future<void> setUserData(
      String id, String name, String email, String lastFlightId) async {
    final CollectionReference pilotsRef = _fireStore.collection('pilots');
    Map<String, String> pilot = {
      "id": id,
      "fullName": name,
      "email": email,
      "lastFlightId": lastFlightId
    };
    await pilotsRef.doc(id).set(pilot);
  }

  void fetchFlightList() {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final result = {};
  }
}
