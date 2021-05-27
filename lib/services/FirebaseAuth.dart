import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  //Stream<User> get authStateChanges =>_firebaseAuth.authStateChanges();

  Future<Map> signIn({required String email, required String password}) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      bool state = await verifyEmail();
      return {
        "message": 'Sign In Completed',
        "userCredential": userCredential,
        "state": state,
      };
    } on FirebaseAuthException catch (e) {
      return {"message": e.message, "userCredential": null, "state": false};
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

  Future<void> logOut() async {
    try {
      var user = _firebaseAuth;
      user.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<bool> verifyEmail() async {
    try {
      var user = _firebaseAuth.currentUser;
      print(user!.email);
      user.reload();
      return user.emailVerified;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<String> returnUserEmail() async {
    try {
      var user = await _firebaseAuth.currentUser;
      String? email = user!.email;
      return email!;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }
}
