import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  //Stream<User> get authStateChanges =>_firebaseAuth.authStateChanges();

  Future<Map> signIn({required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return {"message": 'Sign In Completed', "userCredential": userCredential};
    } on FirebaseAuthException catch (e) {
      return {"message": e.message, "userCredential": null};
    }
  }

  Future<Map> signUp({required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print(userCredential);
      return {"message": 'Sign In Completed', "userCredential": userCredential};
    } on FirebaseAuthException catch (e) {
      return {"message": e.message, "userCredential": null};
    }
  }
}
