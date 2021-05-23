import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _firestore;

  FireStoreService(this._firestore);

  Future<void> setUserData(String id, String name, String email) async {
    final CollectionReference pilotsRef =
        FirebaseFirestore.instance.collection('pilots');
    Map<String, String> pilot = {"id": id, "fullName": name, "email": email};
    await pilotsRef.doc(id).set(pilot);
  }
}
